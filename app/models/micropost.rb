# == Schema Information
#
# Table name: microposts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 160 }

  has_one :replying_relationships, foreign_key: 'reply_micropost_id', class_name: 'ReplyRelationship', dependent: :destroy
  has_one :replying, through: :replying_relationships, source: :main_micropost
  has_many :replied_relationships, foreign_key: 'main_micropost_id', class_name: 'ReplyRelationship', dependent: :destroy
  has_many :replied, through: :replied_relationships, source: :reply_micropost
  has_many :main_notifications, foreign_key: 'main_micropost_id', class_name: 'Notification', dependent: :destroy
  has_many :reply_notifications, foreign_key: 'reply_micropost_id', class_name: 'Notification', dependent: :destroy

  def create_notification_reply_micropost!(current_user, reply_micropost_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Micropost.eager_load(:replying_relationships).select(:user_id).
      where('reply_relationships.main_micropost_id = :id', id: id).
      where.not('microposts.user_id = :user_id', user_id: current_user.id).distinct

    temp_ids.each do |temp_id|
      save_notification_reply_micropost!(current_user, reply_micropost_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_reply_micropost!(current_user, reply_micropost_id, user_id) if temp_ids.blank?
  end

  def save_notification_reply_micropost!(current_user, reply_micropost_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      main_micropost_id: id,
      reply_micropost_id: reply_micropost_id,
      visited_id: visited_id,
      action: 'reply'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end

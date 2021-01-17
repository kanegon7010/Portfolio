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

end

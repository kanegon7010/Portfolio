# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  message    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_messages_on_room_id  (room_id)
#  index_messages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  validates :message, presence: true
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  def create_notification_message!(current_user, visited_id)
    # visited_id = Entries.where(room_id: self.id).where.not(user_id: current_user.id)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and message_id = ? and action = ? ", current_user.id, visited_id, id, 'message'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        message_id: id,
        visited_id: visited_id,
        action: 'message'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end

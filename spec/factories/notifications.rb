# == Schema Information
#
# Table name: notifications
#
#  id                 :bigint           not null, primary key
#  action             :string(255)      default(""), not null
#  checked            :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  main_micropost_id  :bigint
#  message_id         :bigint
#  reply_micropost_id :bigint
#  visited_id         :bigint           not null
#  visitor_id         :bigint           not null
#
# Indexes
#
#  index_notifications_on_main_micropost_id   (main_micropost_id)
#  index_notifications_on_message_id          (message_id)
#  index_notifications_on_reply_micropost_id  (reply_micropost_id)
#  index_notifications_on_visited_id          (visited_id)
#  index_notifications_on_visitor_id          (visitor_id)
#
# Foreign Keys
#
#  fk_rails_...  (main_micropost_id => microposts.id)
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (reply_micropost_id => microposts.id)
#  fk_rails_...  (visited_id => users.id)
#  fk_rails_...  (visitor_id => users.id)
#
FactoryBot.define do
  factory :notification do
    
  end
end

# == Schema Information
#
# Table name: reply_relationships
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  main_micropost_id  :bigint
#  reply_micropost_id :bigint
#
# Indexes
#
#  index_reply_relationships_on_main_micropost_id   (main_micropost_id)
#  index_reply_relationships_on_reply_micropost_id  (reply_micropost_id)
#
# Foreign Keys
#
#  fk_rails_...  (main_micropost_id => microposts.id)
#  fk_rails_...  (reply_micropost_id => microposts.id)
#
class ReplyRelationship < ApplicationRecord
  belongs_to :main_micropost, class_name: "Micropost"
  belongs_to :reply_micropost, class_name: "Micropost"
end

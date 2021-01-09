# == Schema Information
#
# Table name: cvs
#
#  id         :bigint           not null, primary key
#  display    :boolean          default(TRUE), not null
#  education  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_cvs_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Cv < ApplicationRecord
  belongs_to :user

  has_many :objectives
  accepts_nested_attributes_for :objectives, allow_destroy: true

  has_many :summaries
  accepts_nested_attributes_for :summaries, allow_destroy: true

  has_many :skills
  accepts_nested_attributes_for :skills, allow_destroy: true

  has_many :qualifications
  accepts_nested_attributes_for :qualifications, allow_destroy: true

  has_many :work_experiences
  accepts_nested_attributes_for :work_experiences, allow_destroy: true
  
end

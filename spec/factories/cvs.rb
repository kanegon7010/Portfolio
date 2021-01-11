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
FactoryBot.define do
  factory :cv do
    association :user 
    education {"大学"}

    trait :with_nested_instances do
      after( :create ) do |cv|
        create :objective, cv_id: cv.id
        create :qualification, cv_id: cv.id
        create :skill, cv_id: cv.id
        create :summary, cv_id: cv.id
        create :work_experience, cv_id: cv.id
      end
    end
  end
end

# == Schema Information
#
# Table name: qualifications
#
#  id         :bigint           not null, primary key
#  display    :boolean          default(TRUE), not null
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cv_id      :bigint           not null
#
# Indexes
#
#  index_qualifications_on_cv_id  (cv_id)
#
# Foreign Keys
#
#  fk_rails_...  (cv_id => cvs.id)
#
FactoryBot.define do
  factory :qualification do
    association :cv
    name { "qualification資格" }
  end
end

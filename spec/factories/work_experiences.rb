# == Schema Information
#
# Table name: work_experiences
#
#  id          :bigint           not null, primary key
#  description :text(65535)
#  display     :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  cv_id       :bigint           not null
#
# Indexes
#
#  index_work_experiences_on_cv_id  (cv_id)
#
# Foreign Keys
#
#  fk_rails_...  (cv_id => cvs.id)
#
FactoryBot.define do
  factory :work_experience do
    cv { nil }
    description { "MyText" }
  end
end

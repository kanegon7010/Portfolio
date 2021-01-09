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
    user { nil }
  end
end

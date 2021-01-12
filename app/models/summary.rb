# == Schema Information
#
# Table name: summaries
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
#  index_summaries_on_cv_id  (cv_id)
#
# Foreign Keys
#
#  fk_rails_...  (cv_id => cvs.id)
#
class Summary < ApplicationRecord
  belongs_to :cv
end

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
require 'rails_helper'

RSpec.describe WorkExperience, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

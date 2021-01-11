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
  describe 'Association' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Cvとのアソシエーション' do
      let(:target) { :cv }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to 
      end
      it 'cvと関連していること' do
         expect(association.class_name).to eq 'Cv' 
      end
    end
  end
end

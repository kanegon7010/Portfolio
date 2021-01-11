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
require 'rails_helper'

RSpec.describe Cv, type: :model do
  describe 'Association' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Userとのアソシエーション' do
      let(:target) { :user }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to 
      end
      it 'Cvと関連していること' do
         expect(association.class_name).to eq 'User' 
      end
    end

    context 'Objectivesとのアソシエーション' do
      let(:target) { :objectives }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Objectiveと関連していること' do
         expect(association.class_name).to eq 'Objective' 
      end
    end

    context 'qualificationsとのアソシエーション' do
      let(:target) { :qualifications }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Qualificationと関連していること' do
        expect(association.class_name).to eq 'Qualification' 
      end
    end

    context 'skillsとのアソシエーション' do
      let(:target) { :skills }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Skillと関連していること' do
         expect(association.class_name).to eq 'Skill' 
      end
    end

    context 'summariesとのアソシエーション' do
      let(:target) { :summaries }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Summaryと関連していること' do
         expect(association.class_name).to eq 'Summary' 
      end
    end

    context 'work_experiencesとのアソシエーション' do
      let(:target) { :work_experiences }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'WorkExperienceと関連していること' do
         expect(association.class_name).to eq 'WorkExperience' 
      end
    end
  end
end

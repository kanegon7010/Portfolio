# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'Association' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Entryとのアソシエーション' do
      let(:target) { :entries }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Entryと関連していること' do
         expect(association.class_name).to eq 'Entry' 
      end
    end

    context 'Messageとのアソシエーション' do
      let(:target) { :messages }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Messageと関連していること' do
         expect(association.class_name).to eq 'Message' 
      end
    end

  end
end

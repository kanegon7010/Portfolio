# == Schema Information
#
# Table name: entries
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_entries_on_room_id  (room_id)
#  index_entries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'Association' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Userとのアソシエーション' do
      let(:target) { :user }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to 
      end
      it 'Userと関連していること' do
         expect(association.class_name).to eq 'User' 
      end
    end

    context 'Roomとのアソシエーション' do
      let(:target) { :room }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to 
      end
      it 'Roomと関連していること' do
         expect(association.class_name).to eq 'Room' 
      end
    end

  end
end

# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  message    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_messages_on_room_id  (room_id)
#  index_messages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
  #  fk_rails_...  (user_id => users.id)
  #
  require 'rails_helper'

RSpec.describe Message, type: :model do
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

    context 'Notificationとのアソシエーション' do
      let(:target) { :notifications }
      it 'has_many（1対多）になっていること' do
        expect(association.macro).to eq :has_many
      end
      it 'Notificationと関連していること' do
        expect(association.class_name).to eq 'Notification' 
      end
    end

  end
end

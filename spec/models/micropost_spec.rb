# == Schema Information
#
# Table name: microposts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe 'Association' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'replying_relationships（reply_relationships）とのアソシエーション' do
      let(:target) { :replying_relationships }
      it 'has_one（1対1）になっていること' do
         expect(association.macro).to eq :has_one
      end
      it 'ReplyRelationshipと関連していること' do
         expect(association.class_name).to eq 'ReplyRelationship' 
      end
    end

    context 'replied_relationships（reply_relationships）とのアソシエーション' do
      let(:target) { :replied_relationships }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'ReplyRelationshipと関連していること' do
         expect(association.class_name).to eq 'ReplyRelationship' 
      end
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

    context 'main_notifications（notifications）とのアソシエーション' do
      let(:target) { :main_notifications }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Notificationと関連していること' do
         expect(association.class_name).to eq 'Notification' 
      end
    end

    context 'reply_notifications（notifications）とのアソシエーション' do
      let(:target) { :reply_notifications }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Notificationと関連していること' do
         expect(association.class_name).to eq 'Notification' 
      end
    end
    
  end
end

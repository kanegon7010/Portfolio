# == Schema Information
#
# Table name: notifications
#
#  id                 :bigint           not null, primary key
#  action             :string(255)      default(""), not null
#  checked            :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  main_micropost_id  :bigint
#  message_id         :bigint
#  reply_micropost_id :bigint
#  visited_id         :bigint           not null
#  visitor_id         :bigint           not null
#
# Indexes
#
#  index_notifications_on_main_micropost_id   (main_micropost_id)
#  index_notifications_on_message_id          (message_id)
#  index_notifications_on_reply_micropost_id  (reply_micropost_id)
#  index_notifications_on_visited_id          (visited_id)
#  index_notifications_on_visitor_id          (visitor_id)
#
# Foreign Keys
#
#  fk_rails_...  (main_micropost_id => microposts.id)
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (reply_micropost_id => microposts.id)
#  fk_rails_...  (visited_id => users.id)
#  fk_rails_...  (visitor_id => users.id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do

  describe 'Association' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'main_micropost(micropost)とのアソシエーション' do
      let(:target) { :main_micropost }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to
      end
      it 'Micropostと関連していること' do
         expect(association.class_name).to eq 'Micropost' 
      end
    end

    context 'reply_micropost(micropost)とのアソシエーション' do
      let(:target) { :main_micropost }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to
      end
      it 'Micropostと関連していること' do
         expect(association.class_name).to eq 'Micropost' 
      end
    end

    context 'Messageとのアソシエーション' do
      let(:target) { :message }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to
      end
      it 'Messageと関連していること' do
         expect(association.class_name).to eq 'Message' 
      end
    end

    context 'visitor(user)とのアソシエーション' do
      let(:target) { :visitor }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to
      end
      it 'Userと関連していること' do
         expect(association.class_name).to eq 'User' 
      end
    end

    context 'visited(user)とのアソシエーション' do
      let(:target) { :visited }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to
      end
      it 'Userと関連していること' do
         expect(association.class_name).to eq 'User' 
      end
    end

  end
end

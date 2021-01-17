# == Schema Information
#
# Table name: reply_relationships
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  main_micropost_id  :bigint
#  reply_micropost_id :bigint
#
# Indexes
#
#  index_reply_relationships_on_main_micropost_id   (main_micropost_id)
#  index_reply_relationships_on_reply_micropost_id  (reply_micropost_id)
#
# Foreign Keys
#
#  fk_rails_...  (main_micropost_id => microposts.id)
#  fk_rails_...  (reply_micropost_id => microposts.id)
#
require 'rails_helper'

RSpec.describe ReplyRelationship, type: :model do

  describe 'Association' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'replying（Micropostモデル）とのアソシエーション' do
      let(:target) { :main_micropost }
      it 'belong_to（１対多）になっていること' do
        expect(association.macro).to eq :belongs_to 
      end
      it 'Micropost（replying)と関連していること' do
        expect(association.class_name).to eq 'Micropost' 
      end
    end

    context 'replied（Micropostモデル）とのアソシエーション' do
      let(:target) { :reply_micropost }
      it 'belong_to（１対多）になっていること' do
        expect(association.macro).to eq :belongs_to 
      end
      it 'Micropost（replied)と関連していること' do
        expect(association.class_name).to eq 'Micropost'  
      end
    end
  end
end

# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint
#  following_id :bigint
#
# Indexes
#
#  index_relationships_on_follower_id                   (follower_id)
#  index_relationships_on_follower_id_and_following_id  (follower_id,following_id) UNIQUE
#  index_relationships_on_following_id                  (following_id)
#
# Foreign Keys
#
#  fk_rails_...  (follower_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'Association' do
    let(:association) do
       # reflect_on_associationで対象のクラスと引数で指定するクラスの関連を返す
       # described_class = RSpec.describeのあとのクラス名のこと 
       described_class.reflect_on_association(target)
    end

    context 'following（Userモデル）とのアソシエーション' do
      let(:target) { :following }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to 
      end
      it 'User（following)と関連していること' do
         expect(association.class_name).to eq 'User' 
      end
    end

    context 'follower（Userモデル）とのアソシエーション' do
      let(:target) { :follower }
      it 'belong_to（１対多）になっていること' do
         expect(association.macro).to eq :belongs_to 
      end
      it 'User（follower)と関連していること' do
         expect(association.class_name).to eq 'User'  
      end
    end
  end
end

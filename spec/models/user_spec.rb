# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  username               :string(255)      default("")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  service_id             :string(255)      default(""), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_service_id            (service_id) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validation' do
    let(:user) { build(:user) }
    let(:user2) { create(:user) }

    subject { user.valid? }

    it "サービスID、ユーザー名、メール、パスワードがある場合、有効である" do
      user
      expect(user).to be_valid
    end

    context 'サービスID（service_id）' do
      it '6文字以上（validationも正常）の場合、有効である。' do
        user.service_id = '123abc'
        is_expected.to eq true
      end
      it '6文字以上（validationは異常）の場合、無効である。' do
        user.service_id = '12@abc'
        is_expected.to eq false
      end
      it '5文字以下（validationも正常）の場合、無効である。' do
        user.service_id = '12abc'
        is_expected.to eq false
      end
      it '5文字以下（validationは異常）の場合、無効である。' do
        user.service_id = '12@ab'
        is_expected.to eq false
      end
      it '未入力のときエラーとなる' do
        user.service_id = ''
        user.valid?
        expect(user.errors[:service_id]).to include( "が入力されていません。" )
      end
      it 'ユニークじゃない場合妥当ではないと判定されていること' do
        user.service_id = user2.service_id
        user.save
        expect(user).not_to be_valid
      end
      it 'ユニークじゃない場合エラーとなる' do
        user.service_id = user2.service_id
        user.save
        expect(user.errors[:service_id]).to include( "は既に使用されています。" )
      end
    end

    context 'ユーザー名（username）' do
      it '1文字以上の場合、有効である。' do
        user.username = '1'
        is_expected.to eq true
      end
      it '未入力のときエラーとなる' do
        user.username = ''
        user.valid?
        expect(user.errors[:username]).to include( "が入力されていません。" )
      end
    end

    context 'メールアドレス（email）' do
      it '@が含まれている文字列（先頭・末尾を除く）の場合、有効である。' do
        user.email = '1@aiu.com'
        is_expected.to eq true
      end
      it '@が先頭にある文字列の場合、無効である。' do
        user.email = '@1aiu.com'
        is_expected.to eq false
      end
      it '@が末尾にある文字列の場合、無効である。' do
        user.email = '1aiu.com@'
        is_expected.to eq false
      end
      it '未入力のときエラーとなる' do
        user.email = ''
        user.valid?
        expect(user.errors[:email]).to include( "が入力されていません。" )
      end
      it 'ユニークじゃない場合妥当ではないと判定されていること' do
        user.email = user2.email
        user.save
        expect(user).not_to be_valid
      end
      it 'ユニークじゃない場合エラーとなる' do
        user.email = user2.email
        user.save
        expect(user.errors[:email]).to include( "は既に使用されています。" )
      end
    end

    context 'パスワード（password）' do
      it '6文字以上（validationも正常）かつ、確認用と一致の場合、有効である。' do
        user.password = 'pass12'
        user.password_confirmation = 'pass12'
        is_expected.to eq true
      end
      it '6文字以上（validationも正常）かつ、確認用と不一致の場合、無効である。' do
        user.password = 'pass12'
        user.password_confirmation = 'pass12'
        is_expected.to eq true
      end
      it '6文字以上（validationは異常）の場合、無効である。' do
        user.password = 'pas#12'
        user.password_confirmation = 'pas#12'
        is_expected.to eq false
      end
      it '5文字以下（validationも正常）の場合、無効である。' do
        user.password = 'pass1'
        user.password_confirmation = 'pass1'
        is_expected.to eq false
      end
      it '5文字以下（validationは異常）の場合、無効である。' do
        user.password = 'pass#'
        user.password_confirmation = 'pass#'
        is_expected.to eq false
      end
      it '未入力のときエラーとなる' do
        user.password = ''
        user.password_confirmation = ''
        user.valid?
        expect(user.errors[:password]).to include( "が入力されていません。" )
      end
    end
  end

  
  describe 'Association' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'following_relationships（relationship）とのアソシエーション' do
      let(:target) { :following_relationships }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'User（following)と関連していること' do
         expect(association.class_name).to eq 'Relationship' 
      end
    end

    context 'follower_relationships（relationship）とのアソシエーション' do
      let(:target) { :follower_relationships }
      it 'has_many（1対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'User（following)と関連していること' do
         expect(association.class_name).to eq 'Relationship' 
      end
    end

    context 'Entryとのアソシエーション' do
      let(:target) { :entries }
      it 'has_many（１対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Entryと関連していること' do
         expect(association.class_name).to eq 'Entry' 
      end
    end

    context 'Messageとのアソシエーション' do
      let(:target) { :messages }
      it 'has_many（１対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Messageと関連していること' do
         expect(association.class_name).to eq 'Message' 
      end
    end

    context 'Micropostとのアソシエーション' do
      let(:target) { :microposts }
      it 'has_many（１対多）になっていること' do
         expect(association.macro).to eq :has_many
      end
      it 'Micropostと関連していること' do
         expect(association.class_name).to eq 'Micropost' 
      end
    end

    context 'Cvとのアソシエーション' do
      let(:target) { :cv }
      it 'has_one（1対1）になっていること' do
         expect(association.macro).to eq :has_one
      end
      it 'Cvと関連していること' do
         expect(association.class_name).to eq 'Cv' 
      end
    end
  end
end

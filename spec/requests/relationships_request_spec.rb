require 'rails_helper'
require 'pp'

RSpec.describe "Relationships", type: :request do
	let!(:user) { create(:user) }
	let!(:testuser) { create(:testuser) }

	describe 'POST relationship #create' do
		context 'ログインしている場合' do
			before do
				sign_in user
			end
			it 'リクエストが成功すること' do
				post relationships_path, params: { relationship: { following_id: testuser.id } }, xhr: true
				expect(response.status).to eq 200
			end
			it 'createが成功すること' do
				expect do
					post relationships_path, params: { relationship: { following_id: testuser.id } }, xhr: true
				end.to change(Relationship, :count).by 1
			end
		end
		context 'ログインしていない場合' do
			it 'リクエストが失敗すること' do
				post relationships_path, params: { relationship: { following_id: testuser.id } }, xhr: true
				expect(response.status).to eq 401
			end
		end
  end

  describe 'DELETE relationship #destroy' do
    let(:followed){ create( :relationship, follower_id: user.id, following_id: testuser.id ) }
    context 'ログインしている場合' do
			before do
        sign_in user
			end
			it 'リクエストが成功すること' do
        delete relationship_path(followed), params: { relationship: { following_id: testuser.id } }, xhr: true
				expect(response.status).to eq 200
			end
      it 'deleteが成功すること' do
        #expectで、letの遅延評価によりfollowedが作成されてしまうため、countが変わらないように
        #expectの前に変数を宣言している。
        followed 
				expect do
          delete relationship_path(followed), params: { relationship: { following_id: testuser.id } }, xhr: true
				end.to change(Relationship, :count).by -1
			end
		end
		context 'ログインしていない場合' do
			it 'リクエストが失敗すること' do
        delete relationship_path(followed), params: { relationship: { following_id: testuser.id } }, xhr: true
				expect(response.status).to eq 401
			end
		end
  end

  describe 'get user #followings' do
		context 'ログインしている場合' do
			before do
				sign_in user
			end
			it 'ユーザーが存在しリクエストが成功すること' do
				get followings_user_path(user)
				expect(response.status).to eq 200
			end
      it 'ユーザーが存在せずリクエストが失敗すること' do
        testuser_id = testuser.id
        testuser.destroy
        expect{ get followings_user_path(testuser_id) }.to raise_error ActiveRecord::RecordNotFound
			end
		end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        get followings_user_path(user)
        expect(response).to redirect_to new_user_session_path
      end
		end
  end

  describe 'get user #followers' do
		context 'ログインしている場合' do
			before do
				sign_in user
			end
			it 'ユーザーが存在しリクエストが成功すること' do
				get followers_user_path(user)
				expect(response.status).to eq 200
			end
      it 'ユーザーが存在せずリクエストが失敗すること' do
        testuser_id = testuser.id
        testuser.destroy
        expect{ get followers_user_path(testuser_id) }.to raise_error ActiveRecord::RecordNotFound
			end
		end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        get followers_user_path(user)
        expect(response).to redirect_to new_user_session_path
      end
		end
  end
end

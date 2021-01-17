require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  let!(:user) { create(:user) }
  let!(:micropost_params){ { micropost: { content: 'micropostを送信' } } }

  describe 'POST micropost #create' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'リクエストが成功すること' do
        post microposts_path, params: micropost_params, xhr: true
        expect(response.status).to eq 200
      end
      it 'createが成功すること' do
        expect do
          post microposts_path, params: micropost_params, xhr: true
        end.to change(Micropost, :count).by 1
      end
    end
    context 'ログインしていない場合' do
      it 'リクエストが失敗すること' do
        post microposts_path, params: micropost_params, xhr: true
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE micropost #destroy' do
    let(:micropost){ create( :micropost, content: 'micropostを送信', user_id: user.id ) }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'リクエストが成功すること' do
        delete micropost_path(micropost), params: { id: micropost.id }, xhr: true
        expect(response.status).to eq 200
      end
      it 'deleteが成功すること' do
        micropost
        expect do
          delete micropost_path(micropost), params: { id: micropost.id }, xhr: true
        end.to change(Micropost, :count).by -1
      end
    end
    context 'ログインしていない場合' do
      it 'リクエストが失敗すること' do
        delete micropost_path(micropost), params: { id: micropost.id }, xhr: true
        expect(response.status).to eq 401
      end
    end
  end

  describe 'GET micropost #show' do
    let(:micropost){ create( :micropost, content: 'micropostを送信', user_id: user.id ) }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      context 'micropostが存在する時' do
        it 'ページを表示すること' do
          expect( get micropost_path(micropost.id) ).to eq 200
        end
      end
      context 'micropostが存在しない場合' do
        it 'エラーが発生すること' do
          no_micropost = micropost.id + 1
          expect{ get micropost_path(no_micropost) }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        get micropost_path(micropost.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end

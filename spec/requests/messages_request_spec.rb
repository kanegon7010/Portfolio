require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let!(:user) { create(:user) }
  let!(:testuser) { create(:testuser) }
  let!(:followed){ create( :relationship, follower_id: user.id, following_id: testuser.id ) }
  let!(:follower){ create( :relationship, follower_id: testuser.id, following_id: user.id ) }
  let!(:entry1){ create( :entry, user_id: user.id ) }
  let!(:entry2){ create( :entry, user_id: testuser.id, room_id: entry1.room_id  ) }
  let!(:message_params){ { message: { message: "メッセージ", room_id: entry1.room_id } } }

  describe 'POST message #create' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'リクエストが成功すること' do
        post messages_path, params: message_params, xhr: true
        expect(response.status).to eq 200
      end
      it 'createが成功すること' do
        expect do
          post messages_path, params: message_params, xhr: true
        end.to change(Message, :count).by 1
      end
      context '相互フォローを行っていない場合' do
        it 'リダイレクトすること' do
          user.unfollow(testuser)
          post messages_path, params: message_params, xhr: true
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'ログインしていない場合' do
      it 'リクエストが失敗すること' do
        post messages_path, params: message_params, xhr: true
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE message #destroy' do
    let(:message){ create( :message, message: "メッセージ", room_id: entry1.room_id, user_id: user.id ) }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'リクエストが成功すること' do
        delete message_path(message), params: { message: { room_id: entry1.room_id }, id: message.id }, xhr: true
        expect(response.status).to eq 200
      end
      it 'deleteが成功すること' do
        message
        expect do
          delete message_path(message), params: { message: { room_id: entry1.room_id }, id: message.id }, xhr: true
        end.to change(Message, :count).by -1
      end
      context '相互フォローを行っていない場合' do
        it 'リダイレクトすること' do
          user.unfollow(testuser)
          delete message_path(message), params: { message: { room_id: entry1.room_id }, id: message.id }, xhr: true
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'ログインしていない場合' do
      it 'リクエストが失敗すること' do
        delete message_path(message), params: { message: { room_id: entry1.room_id }, id: message.id }, xhr: true
        expect(response.status).to eq 401
      end
    end
  end

end

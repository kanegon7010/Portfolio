require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  let!(:user) { create(:user) }
  let!(:testuser) { create(:testuser) }
  let!(:testuser2) { create(:testuser) }
  let!(:followed){ create( :relationship, follower_id: user.id, following_id: testuser.id ) }
  let!(:follower){ create( :relationship, follower_id: testuser.id, following_id: user.id ) }
  let!(:followed2){ create( :relationship, follower_id: testuser.id, following_id: testuser2.id ) }
  let!(:follower2){ create( :relationship, follower_id: testuser2.id, following_id: testuser.id ) }

  describe 'GET rooms #index' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'ユーザー一覧ページを表示すること' do
        expect( get rooms_path ).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        get rooms_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET rooms #show' do
    let(:entry1){ create( :entry, user_id: user.id ) }
    let(:entry2){ create( :entry, user_id: testuser.id, room_id: entry1.room_id  ) }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      context 'ルームが作成されている場合' do
        it 'DMページを表示すること' do
          entry1
          entry2
          expect( get room_path(entry1.room_id) ).to eq 200
        end
        context 'ログインユーザーと無関係ならば' do
          let(:entry3){ create( :entry, user_id: testuser.id ) }
          let(:entry4){ create( :entry, user_id: testuser2.id, room_id: entry3.room_id ) } 
          it 'リダイレクトすること' do
            entry3
            entry4
            get room_path(entry3.room_id)
            expect(response).to redirect_to root_path
          end
        end
      end
      context 'ルームが作成されていない場合' do
        it 'エラーが発生すること' do
          noroom = entry1.room_id + 1
          expect{ get room_path(noroom) }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        get room_path(entry1.room_id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST rooms #create' do
    let(:room_params){ { user_id: testuser.id } }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'リクエストが成功すること' do
        post rooms_path, params: room_params
        expect(response.status).to eq 302
      end
      it 'createが成功すること' do
        expect do
          post rooms_path, params: room_params
        end.to change(Room, :count).by 1
      end
      context '相互フォローを行っていない場合' do
        it 'リダイレクトすること' do
          post rooms_path, params: { user_id: testuser2.id }
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        post rooms_path, params: room_params
        expect(response.status).to eq 302
      end
      it 'ログインページにリダイレクトすること' do
        post rooms_path, params: room_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end

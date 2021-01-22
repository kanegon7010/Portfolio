require 'rails_helper'

RSpec.describe "UserAuthentications", type: :request do
  let(:user) { create(:user) }
  let(:testuser) { create(:testuser) }

  describe 'POST registration #create' do
    let(:user_params) { attributes_for(:user) }
    let(:invalid_user_params) { attributes_for(:user, service_id: "") }

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it 'createが成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'ルートページにリダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
      end

      it 'エラーが表示されること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include 'エラーが発生したため'
      end
    end
  end

  describe 'GET registration #edit' do
    subject { get edit_user_registration_path }
    context 'ログインしている場合' do
      before do
        ##deviseでメール認証機能をつけている場合はサインインの前に user.confirm を行う必要がある。
        #user.confirm
        sign_in user
      end
      it 'リクエストが成功すること' do
        is_expected.to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT registration #update' do
    let(:userupdate){ {username: "名前２"} }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it "リクエストが成功すること" do
        put user_registration_path, params: { user: userupdate }
        expect(response.status).to eq 302
      end
      it "更新が成功すること" do
        put user_registration_path, params: { user: userupdate }
        expect(user.reload.username).to eq "名前２"
      end
      it "ユーザー編集ページへリダイレクトすること" do
        put user_registration_path, params: { user: userupdate }
        expect(response).to redirect_to root_path
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトされること' do
        put user_registration_path, params: { user: userupdate }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE registration #destroy' do
    context 'ログインしている場合' do
			before do
        sign_in user
			end
			it 'リクエストが成功すること' do
        delete user_registration_path
				expect(response.status).to eq 302
			end
      it 'deleteが成功すること' do
        user 
				expect do
          delete user_registration_path
				end.to change(User, :count).by -1
      end
      it 'ログインページにリダイレクトされること' do
        delete user_registration_path
				expect(response).to redirect_to new_user_session_path
			end
		end
		context 'ログインしていない場合' do
			it 'リクエストが失敗すること' do
        delete user_registration_path
				expect(response.status).to eq 302
			end
		end
  end

  describe 'POST session #create' do
    context 'パラメータが妥当な場合' do
      let(:user_login) { {email: user.email, password: user.password} }

      it 'リクエストが成功すること' do
        post user_session_path, params: { user: user_login }
        expect(response.status).to eq 302
      end

      it 'ルートページにリダイレクトされること' do
        post user_session_path, params: { user: user_login }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_session_path, params: { user: {email: user.email, password: "" } }
        expect(response.status).to eq 200
      end

      it 'エラーが表示されること' do
        post user_session_path, params: { user: {email: user.email, password: "" } }
        expect(response.body).to include 'Email もしくはパスワードが不正です。'
      end
    end
  end

  describe 'DELETE session #destroy' do
    context 'ログインしている場合' do
			before do
        sign_in user
			end
			it 'リクエストが成功すること' do
        delete destroy_user_session_path
				expect(response.status).to eq 302
			end
      it 'ログインページにリダイレクトされること' do
        delete destroy_user_session_path
        expect(response).to redirect_to new_user_session_path
      end
		end
		context 'ログインしていない場合' do
			it 'リクエストが失敗すること' do
        delete destroy_user_session_path
				expect(response.status).to eq 302
			end
		end
  end

  describe 'GET #index' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'ユーザー一覧ページを表示すること' do
        expect( get "/users" ).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        get "/users"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      context 'ユーザーが存在する時' do
        it '個別ページを表示すること' do
          expect( get "/users/#{testuser.id}" ).to eq 200
        end
      end
      context 'ユーザーが存在しない場合' do
        it 'エラーが発生すること' do
          testuser_id = testuser.id
          testuser.destroy
          expect{ get "/users/#{testuser_id}" }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        user_id = user.id
        get "/users/#{user_id}"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
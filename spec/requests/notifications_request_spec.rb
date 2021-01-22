require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let!(:user) { create(:user) }

  describe 'get Notification #index' do
  context 'ログインしている場合' do
    before do
      sign_in user
    end
    it 'リクエストが成功すること' do
      get notifications_path
      expect(response.status).to eq 200
    end
  end
  context 'ログインしていない場合' do
    it 'ログインページにリダイレクトすること' do
      get notifications_path
      expect(response).to redirect_to new_user_session_path
    end
  end
end

end

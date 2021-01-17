require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let!(:user) { create(:user) }

  describe 'GET root #index' do
    let(:micropost){ create( :micropost, content: 'micropostを送信', user_id: user.id ) }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'ルートページを表示すること' do
        expect( get root_path ).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ルートページを表示すること' do
        expect( get root_path ).to eq 200
      end
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/homes/show"
      expect(response).to have_http_status(:success)
    end
  end

end

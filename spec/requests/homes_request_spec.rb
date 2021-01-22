require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let!(:user) { create(:user) }

  describe 'GET root #index' do
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

  describe "GET /search" do
    let(:q){ { q: { username_or_service_id_cont: 'test' } } }
    let(:q2){ { q2: { username_or_service_id_cont: 'test2' } } }
    let(:m){ { m: { content_cont: 'test3' } } }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '検索ページを表示すること(sidebar)' do
        get search_path, params: q
        expect( response.status ).to eq 200
      end
      it '検索ページを表示すること(search)' do
        get search_path, params: q2
        expect( response.status ).to eq 200
      end
      it '検索ページを表示すること(micropost)' do
        get search_path, params: m
        expect( response.status ).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ルートページを表示すること' do
        expect( get new_user_session_path ).to eq 200
      end
      it 'ログインページにリダイレクトすること' do
        get search_path, params: q
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end

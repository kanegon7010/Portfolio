require 'rails_helper'

RSpec.describe "Cvs", type: :request do
  let(:user) { create(:user) }
  let(:cv) { create(:cv, :with_nested_instances) }
  let(:othercv) { create(:cv, :with_nested_instances) }

  before do
    @params_nested = { 
      cv: FactoryBot.attributes_for(:cv, user: user.id).
        merge( 
          objectives_attributes: {
            "0": attributes_for(:objective)
          },
          qualifications_attributes: {
            "0": attributes_for(:qualification)
          },
          skills_attributes: {
            "0": attributes_for(:skill)
          },
          summaries_attributes: {
            "0": attributes_for(:summary)
          },
          work_experiences_attributes: {
            "0": attributes_for(:work_experience)
          }
        )
    }
  end

  describe 'GET cvs #show' do
    context 'ログインしている場合' do
      before do
        sign_in cv.user
      end
      context 'ユーザーが存在する時' do
        it 'マイページを表示すること' do
          expect( get cv_path(id: cv.user.id) ).to eq 200
        end
        it '他ユーザーページを表示すること' do
          expect( get cv_path(id: othercv.user.id) ).to eq 200
        end
      end
      context 'ユーザーが存在しない場合' do
        it 'エラーが発生すること' do
          nobody = cv.user.id + 1
          expect{ get cv_path(id: nobody) }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        get cv_path(id: cv.user.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET cvs #new' do
    context 'ログインしている場合' do
      context 'cvをまだ作成していないユーザーの場合' do
        before do
          sign_in user
        end
        it 'リクエストが成功すること' do
          get new_cv_path(user.id)
          expect(response.status).to eq 200
        end
        it '対象が異なる場合、リダイレクトされること' do
          get new_cv_path(othercv.user.id)
          expect(response.status).to eq 302
        end
        it '対象が異なる場合、ログインユーザーのnewページへリダイレクトされること' do
          get new_cv_path(othercv.user.id)
          expect(response).to redirect_to new_cv_path(user.id)
        end
      end
      context 'cvが作成済みのユーザーの場合' do
        before do
          sign_in cv.user
        end
        it 'リダイレクトすること' do
          get new_cv_path(cv.user.id)
          expect(response.status).to eq 302
        end
        it 'editページへリダイレクトすること' do
          get new_cv_path(cv.user.id)
          expect(response).to redirect_to edit_cv_path(cv.user.id)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get new_cv_path(cv.user.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST cvs #create' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'リクエストが成功すること' do
        post cv_path(id: user.id), params: @params_nested
        expect(response.status).to eq 302
      end
      it 'createが成功すること' do
        expect do
          post cv_path(id: user.id), params: @params_nested
        end.to change(Cv, :count).by 1
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        post cv_path(id: user.id), params: @params_nested
        expect(response.status).to eq 302
      end
      it 'ログインページにリダイレクトすること' do
        post cv_path(id: user.id), params: @params_nested
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET cvs #edit' do
    context 'ログインしている場合' do
      context 'cvをまだ作成していないユーザーの場合' do
        before do
          sign_in user
        end
        it 'リダイレクトすること' do
          get edit_cv_path(user.id)
          expect(response.status).to eq 302
        end
        it 'newページへリダイレクトすること' do
          get edit_cv_path(user.id)
          expect(response).to redirect_to new_cv_path(user.id)
        end
      end 
      context 'cvが作成済みのユーザーの場合' do
        before do
          sign_in cv.user
        end
        it 'リクエストが成功すること' do
          get edit_cv_path(cv.user.id)
          expect(response.status).to eq 200
        end
        it '対象が異なる場合、リダイレクトされること' do
          get edit_cv_path(othercv.user.id)
          expect(response.status).to eq 302
        end
        it '対象が異なる場合、ログインユーザーのeditページへリダイレクトされること' do
          get edit_cv_path(othercv.user.id)
          expect(response).to redirect_to edit_cv_path(cv.user.id)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get edit_cv_path(cv.user.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT cvs #update' do
    context 'ログインしている場合' do
      before do
        sign_in cv.user
      end
      it 'リクエストが成功すること' do
        put cv_path(id: cv.user.id), params: { cv: { id: cv.id, education: "高校" } }
        expect(response.status).to eq 302
      end
      it 'updateが成功すること' do
        put cv_path(id: cv.user.id), params: { cv: { id: cv.id, education: "高校" } }
        expect(cv.reload.education).to eq "高校"
      end
      it "ユーザー編集ページへリダイレクトすること" do
        put cv_path(id: cv.user.id), params: { cv: { id: cv.id, education: "高校" } }
        expect(response).to redirect_to cv_path(id: cv.user.id)
      end
      it "対象がログインユーザー以外の場合、rootへリダイレクトすること" do
        put cv_path(id: othercv.user.id), params: { cv: { id: cv.id, education: "高校" } }
        expect(response).to redirect_to root_path
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        put cv_path(id: cv.user.id), params: { cv: { id: cv.id, education: "高校" } }
        expect(response.status).to eq 302
      end
      it 'ログインページへリダイレクトされること' do
        put cv_path(id: cv.user.id), params: { cv: { id: cv.id, education: "高校" } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Cvs", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/cvs/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/cvs/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/cvs/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/cvs/update"
      expect(response).to have_http_status(:success)
    end
  end

end

require 'rails_helper'

RSpec.describe "Microposts", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/microposts/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/microposts/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end

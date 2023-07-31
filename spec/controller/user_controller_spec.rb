require "rails_helper"

RSpec.describe "Users", type: :request do
  let!(:valid_header) { { 'Authorization' => "Bearer u0eVTbIjp4kW6xRFaVsyj3gkqbvvO0B1lr5s9Si7zXM"} }
  let!(:user) { create(:user, name: 'JohnDoe', email: 'john@example.com', password: 'password', phone_number: "1234567890", user_status: "active", user_type: "admin") }
  let!(:params) {{ user: {
    name: "JohnDoe", email: "john@example.com", password: 'password', phone_number: "1234567890", user_status: "active", user_type: "admin"
    }
  }}

  let!(:edit_profile_params) {{ user: {
    name: "JohnDoe", email: "john@example.com", phone_number: "1234567890"
    }
  }}

  describe "GET /index" do
    it 'returns a successful response' do
      get "/api/v1/user_management/users", headers: valid_header
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a new user with valid header' do
      post "/api/v1/user_management/users", params: params, headers: valid_header
      expect(response).to have_http_status(:created)
    end
  end


  describe "get show" do
    context 'with valid parameters' do
        it 'a user' do
          get :"/api/v1/user_management/users/1", headers: valid_header
          expect(response).to have_http_status(:ok)
           puts response.body
           expect(JSON.parse(response.body)
        end
      end
    end

  describe "Put update profile" do
    context 'with valid parameters' do
        it 'updates user' do
          put :"/api/v1/user_management/users/1", params: edit_profile_params, headers: valid_header
          expect(response).to have_http_status(:ok)
          puts response.body
          expect(JSON.parse(response.body))
        end
      end
    end


end

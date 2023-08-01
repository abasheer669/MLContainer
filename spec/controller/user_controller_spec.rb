require "rails_helper"

RSpec.describe "Users", type: :request do


  let!(:user) { create(:user, name: 'JohnDoe', email: 'john@example.com', password: 'password', phone_number: "1234567890", user_status: "active", user_type: "admin") }
  let!(:user2) { create(:user, name: 'ram', email: 'ram@example.com', password: 'password', phone_number: "1234567890", user_status: "active", user_type: "admin") }
  let!(:user3) { create(:user, name: 'tom', email: 'tom@example.com', password: 'password', phone_number: "1234567890", user_status: "active", user_type: "admin") }

  let!(:valid_header) { fetch_bearer_token("john@example.com", "password")}

  let!(:params) {{ user: {
    name: "JohnDoe", email: "johnCena@example.com", password: 'password', phone_number: "1234567890", user_status: "active", user_type: "admin"
    }
  }}

  let!(:edit_profile_params) {{ user: {
    name: "JohnD", email: "johnD@example.com", phone_number: "12345678901"
    }
  }}

  describe "GET /index" do
    it 'returns a successful response' do
      get "/api/v1/user_management/users?role=admin", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts response.body
      expect(JSON.parse(response.body)[0]["id"]).to eq(user.id)
      expect(JSON.parse(response.body)[0]["name"]).to eq(user.name)
      expect(JSON.parse(response.body)[0]["email"]).to eq(user.email)
    end

    it 'returns all users when no search parameters are provided' do
      get "/api/v1/user_management/users?role=admin&name=", headers: valid_header
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      #puts response_data
      expect(response_data.length).to eq(3)
      expect(response_data[0]['name']).to eq('JohnDoe')
      expect(response_data[1]['name']).to eq('ram')
      expect(response_data[2]['name']).to eq('tom')
    end

    it 'return no users message when no users in table' do
      get "/api/v1/user_management/users?role=employee", headers: valid_header
      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body)
      expect(response_data['message']).to eq("No users found for the given search criteria")
    end
  end

  describe 'POST /create' do
    it 'creates a new user with valid header' do
      post "/api/v1/user_management/users", params: params, headers: valid_header
      expect(response).to have_http_status(:created)
    end

    it 'returns an error for missing parameters' do
      missing_params = { name: 'Invalid User', email: 'invalid-email', password: 'password123' }
      post :"/api/v1/user_management/users", params: { user: missing_params }, headers: valid_header
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns an error for duplicate email' do
      duplicate_params = { name: 'Duplicate User', email: 'john@example.com', phone_number: "1234567890", password: 'password123',user_status: "active", user_type: "admin" }
      post :"/api/v1/user_management/users", params: { user: duplicate_params }, headers: valid_header
      expect(response).to have_http_status(:unprocessable_entity)
      response_data = JSON.parse(response.body)
      expect(response_data["errors"]).to include("User with this email already exists")
    end

  end


  describe "get show" do
    context 'with valid parameters' do
        it 'a user' do
          get :"/api/v1/user_management/users/#{user.id}", headers: valid_header
          expect(response).to have_http_status(:ok)
          #puts response.body
           expect(JSON.parse(response.body))
           expect(JSON.parse(response.body)["id"]).to eq(user.id)
          expect(JSON.parse(response.body)["name"]).to eq(user.name)
          expect(JSON.parse(response.body)["email"]).to eq(user.email)
        end
      end
    end


  describe "Put update profile" do
    context 'with valid parameters' do
        it 'updates user' do
          put :"/api/v1/user_management/users/update_profile", params: edit_profile_params, headers: valid_header
          expect(response).to have_http_status(:ok)
          #puts response.body
        end
      end
    end

end

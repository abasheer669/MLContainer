require "rails_helper"

RSpec.describe "Auth", type: :request do
  let!(:user) { create(:user, name: 'JohncenaDoe', email: 'johncena@example.com', password: 'password', phone_number: "1234567890", user_status: "active", user_type: "admin") }
  let!(:params) {{ grant_type: "password", email: "johncena@example.com", password: 'password' }}
  let!(:invalid_params) {{ grant_type: "password", email: "john@example.com", password: 'password' }}

  describe 'POST #login' do
    it 'returns success with valid credentials' do
      post  :"/api/v1/user_management/login", params: params
      expect(response).to have_http_status(:ok)
    end

    it 'returns unauthorized with invalid credentials' do
      post :"/api/v1/user_management/login", params: invalid_params
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE #logout' do
    it 'returns success when the user is logged out' do
      DELETE :"/api/v1/user_management/logout", headers: valid_header
      expect(response).to have_http_status(:no_content)
      # Test the logout action and expect a successful response.
    end
  end

  # Add more test examples for other actions in your authentication controller.
end

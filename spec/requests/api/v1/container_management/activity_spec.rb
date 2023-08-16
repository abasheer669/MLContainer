require 'rails_helper'

RSpec.describe "Api::V1::ContainerManagement::Activities", type: :request do
  let!(:user) { create(:user, name: 'JohncenaDoe', email: 'johncena@example.com', password: '123456', phone_number: "1234567890", user_status: "active", user_type: "admin") }

  let!(:customer) { create(:customer, name: 'JohnDoe', email: 'john@example.com',owner_name: 'john cena', billing_name: "John B Cena",hourly_rate: 1.4, gst: 10, pst: 10,city: "mumbai", province: "TN", postalcode: "1234",password: '123456', customer_status: 1, customer_type: 1) }
  let!(:valid_header) { fetch_bearer_token("johncena@example.com", "123456")}
  let!(:params) {{ customer: { name: 'JohnDoe', email: 'ABC@example.com',owner_name: 'ABAA', billing_name: "BAA",hourly_rate: 1.4, gst: 10, pst: 10,city: "mumbai", province: "TN", postalcode: "1234",password: '123456', customer_status: "active", customer_type: "maersk"    }}}
  let!(:edit_params) {{ customer: { name: 'JohnBDoe', email: 'ABC@example.com',owner_name: 'ABAAAAA', billing_name: "BAAB",hourly_rate: 11.4, gst: 1.0, pst: 11,city: "mumbai", province: "TN", postalcode: "1234",password: '123456', customer_status: "active", customer_type: "maersk"  }}}


  describe "GET /index" do
    it 'returns a successful response' do
      get " /api/v1/container_management/containers/:container_id/activity", headers: valid_header
      expect(response).to have_http_status(:success)
    end
  end
end

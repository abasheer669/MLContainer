require 'rails_helper'

RSpec.describe "Api::V1::ContainerManagement::Containers", type: :request do
  let!(:user) { create(:user, name: 'JohncenaDoe', email: 'johncena@example.com', password: '123456', phone_number: "1234567890", user_status: "active", user_type: "admin") }
  let!(:customer) { create(:customer, name: 'JohnDoe', email: 'john@example.com',owner_name: 'john cena', billing_name: "John B Cena",hourly_rate: 1.4, gst: 10, pst: 10,city: "mumbai", province: "TN", postalcode: "1234",password: '123456', customer_status: 1, customer_type: 1) }
  let!(:customer2) { create(:customer, name: 'AJohnDoe2', email: 'john2@example.com',owner_name: 'john bcena', billing_name: "John B Cena",hourly_rate: 1.4, gst: 10, pst: 10,city: "mumbai", province: "TN", postalcode: "1234",password: '123456', customer_status: 1, customer_type: 1) }

  let!(:yardname) { create(:yardname,id: 1, yard_name: "AYard") }
  let!(:yardname2) { create(:yardname,id: 2, yard_name: "BYard") }

  let!(:container_height) { create(:container_height,id: 1, height: 10) }
  let!(:container_length) { create(:container_length,id: 1, length: 20) }


  let!(:container) { create(:container, yardname_id: yardname.id, container_number: "XYZ", customer_id: customer.id, container_owner_name: "ABB", submitter_initial: "B" , container_length_id: container_length.id, container_height_id: container_height.id ,container_type: "cold", manufacture_year: 1992, location: "XXX") }
  let!(:comment){create(:comment, comment: "no comments", user_id: user.id, commentable_type: "Container", commentable_id: container.id)}
  let!(:attachment){create(:attachment, attachable_id: container.id, attachable_type: "Container", file_type: "front_side", pre_signed_url: "url")}
  let!(:activity){create(:activity,user_id: user.id, container_id: container.id, activity_date: "22/01/1990", activity_type: "quote_form", activity_status: "quote_draft", total_cost: 25)}


  let!(:container2) { create(:container, yardname_id: yardname2.id, container_number: "MMMZ", customer_id: customer.id, container_owner_name: "ACC", submitter_initial: "B" , container_length_id: container_length.id, container_height_id: container_height.id ,container_type: "cold", manufacture_year: 1992, location: "XXX") }
  let!(:comment2){create(:comment, comment: "no comments. no comments", user_id: user.id, commentable_type: "Container", commentable_id: container2.id)}
  let!(:attachment2){create(:attachment, attachable_id: container2.id, attachable_type: "Container", file_type: "front_side", pre_signed_url: "url")}
  let!(:activity2){create(:activity, user_id: user.id, container_id: container2.id, activity_date: "22/01/1990", activity_type: "quote_form", activity_status: "quote_pending", total_cost: 25)}


  let!(:container3) { create(:container, yardname_id: yardname.id, container_number: "MMMZ", customer_id: customer2.id, container_owner_name: "AAA", submitter_initial: "B" , container_length_id: container_length.id, container_height_id: container_height.id ,container_type: "cold", manufacture_year: 1992, location: "XXX") }
  let!(:comment3){create(:comment, comment: "no comments. no comments", user_id: user.id, commentable_type: "Container", commentable_id: container3.id)}
  let!(:attachment3){create(:attachment, attachable_id: container3.id, attachable_type: "Container", file_type: "front_side", pre_signed_url: "url")}
  let!(:activity3){create(:activity, user_id: user.id, container_id: container3.id, activity_date: "22/01/1990", activity_type: "quote_form", activity_status: "quote_issued", total_cost: 25)}
  let!(:activity4){create(:activity, user_id: user.id, container_id: container3.id, activity_date: "22/01/1990", activity_type: "quote_form", activity_status: "quote_approved", total_cost: 25)}


  let!(:valid_header) { fetch_bearer_token("johncena@example.com", "123456")}
  let!(:params) {{ container: {yardname_id: yardname.id, container_number: "ZZZ", customer_id: customer.id, container_owner_name: "A", submitter_initial: "B" , container_length_id: 1, container_height_id: 1, container_type: "cold", manufacture_year: 1992, location: "XXX", comment: "No comments", left_side: "url", right_side: "url", front_side: "url", interior: "url", under_side: "url", roof: "url" }}}
  let!(:wrong_params) {{ container: {yardname_id: yardname.id, container_number: "ZZZ", customer_id: customer.id, container_owner_name: "A" , container_length_id: 1, container_height_id: 1, container_type: "cold", manufacture_year: 1992, location: "XXX", comment: "No comments", left_side: "url", right_side: "url", front_side: "url", interior: "url", under_side: "url", roof: "url" }}}

  let!(:update_params) {{ container: {yardname_id: yardname.id, container_number: "AAAZZZ", customer_id: customer.id, container_owner_name: "A", submitter_initial: "B" , container_length_id: 1, container_height_id: 1, container_type: "cold", manufacture_year: 1992, location: "XXX", comment: "No comments", left_side: "url", right_side: "url", front_side: "url", interior: "url", under_side: "url", roof: "url" }}}

  let!(:edit_params) {{ customer: { name: 'JohnBDoe', email: 'ABC@example.com',owner_name: 'ABAAAAA', billing_name: "BAAB",hourly_rate: 11.4, gst: 1.0, pst: 11,city: "mumbai", province: "TN", postalcode: "1234",password: '123456', customer_status: "active", customer_type: "maersk"  }}}

  describe "GET /index" do
    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=all", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts "hi"
      # puts JSON.parse(response.body)[1]
      expect(JSON.parse(response.body)[1]["id"]).to eq(container2.id)
      # puts JSON.parse(response.body)[1]["activities"]
      expect(JSON.parse(response.body)[1]["filtered_activity"]["id"]).to eq(activity2.id)
    end

    it 'returns a invalid argument' do
      get "/api/v1/container_management/containers?activity=a", headers: valid_header
      expect(response).to have_http_status(:unprocessable_entity)

    end

    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=all&search=MMMZ", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts JSON.parse(response.body)[1]
      expect(JSON.parse(response.body)[1]["id"]).to eq(container3.id)
      # puts JSON.parse(response.body)[1]["activities"]
      expect(JSON.parse(response.body)[1]["filtered_activity"]["id"]).to eq(activity4.id)
    end


    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=all&customer_name=JohnDoe", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts JSON.parse(response.body)[1]
      expect(JSON.parse(response.body)[1]["id"]).to eq(container2.id)
      # puts JSON.parse(response.body)[1]["activities"]
      expect(JSON.parse(response.body)[1]["filtered_activity"]["id"]).to eq(activity2.id)
    end


    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=all&sort_attribute=customer_name", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts JSON.parse(response.body)
      # expect(JSON.parse(response.body)[1]["id"]).to eq(container2.id)
      # # puts JSON.parse(response.body)[1]["activities"]
      # expect(JSON.parse(response.body)[1]["filtered_activity"]["id"]).to eq(activity2.id)
    end

    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=all&sort_attribute=yardname", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts JSON.parse(response.body)
      # expect(JSON.parse(response.body)[1]["id"]).to eq(container2.id)
      # # puts JSON.parse(response.body)[1]["activities"]
      # expect(JSON.parse(response.body)[1]["filtered_activity"]["id"]).to eq(activity2.id)
    end

    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=all&sort_attribute=activity_status", headers: valid_header
      expect(response).to have_http_status(:success)
      #  puts JSON.parse(response.body)
      # expect(JSON.parse(response.body)[1]["id"]).to eq(container2.id)
      # # puts JSON.parse(response.body)[1]["activities"]
      # expect(JSON.parse(response.body)[1]["filtered_activity"]["id"]).to eq(activity2.id)
    end

    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=all&sort_attribute=activity_status&sort_order=desc", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts JSON.parse(response.body)
      # expect(JSON.parse(response.body)[1]["id"]).to eq(container2.id)
      # # puts JSON.parse(response.body)[1]["activities"]
      # expect(JSON.parse(response.body)[1]["filtered_activity"]["id"]).to eq(activity2.id)
    end

    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=draft&sort_attribute=activity_status", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts JSON.parse(response.body)
      # expect(JSON.parse(response.body)[1]["id"]).to eq(container2.id)
      # # puts JSON.parse(response.body)[1]["activities"]
      # expect(JSON.parse(response.body)[1]["filtered_activity"]["id"]).to eq(activity2.id)
    end


    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=draft&sort_attribute=activity_status&sort_order=desc", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts JSON.parse(response.body)
      # expect(JSON.parse(response.body)[1]["id"]).to eq(container2.id)
      # # puts JSON.parse(response.body)[1]["activities"]
      # expect(JSON.parse(response.body)[1]["filtered_activity"]["id"]).to eq(activity2.id)
    end

    it 'returns a invalid sort attribute response' do
      get "/api/v1/container_management/containers?activity=all&sort_attribute=yardn", headers: valid_header
      expect(response).to have_http_status(:unprocessable_entity)
      # puts JSON.parse(response.body)

    end

    it 'returns search not found' do
      get "/api/v1/container_management/containers?activity=all&search=Z", headers: valid_header
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=draft", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts JSON.parse(response.body)[0]
      expect(JSON.parse(response.body)[0]["id"]).to eq(container.id)
      # puts JSON.parse(response.body)[0]["activities"]
      expect(JSON.parse(response.body)[0]["filtered_activity"]["id"]).to eq(activity.id)
      expect(JSON.parse(response.body)[0]["filtered_activity"]["activity_status"]).to eq(activity.activity_status)
    end


    it 'returns not found' do
      get "/api/v1/container_management/containers?activity=draft&search=Z", headers: valid_header
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=customer_pending", headers: valid_header
      expect(response).to have_http_status(:success)
      #  puts response.body
      expect(JSON.parse(response.body)[0]["id"]).to eq(container3.id)
      # puts JSON.parse(response.body)[0]["activities"]
      expect(JSON.parse(response.body)[0]["filtered_activity"]["id"]).to eq(activity3.id)
      expect(JSON.parse(response.body)[0]["filtered_activity"]["activity_status"]).to eq(activity3.activity_status)
    end

    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=admin_review", headers: valid_header
      expect(response).to have_http_status(:success)
      #  puts response.body
      expect(JSON.parse(response.body)[0]["id"]).to eq(container2.id)
      expect(JSON.parse(response.body)[0]["filtered_activity"]["id"]).to eq(activity2.id)
      expect(JSON.parse(response.body)[0]["filtered_activity"]["activity_status"]).to eq(activity2.activity_status)

    end

    it 'returns a successful response' do
      get "/api/v1/container_management/containers?activity=customer_approved", headers: valid_header
      expect(response).to have_http_status(:success)
      # puts response.body
      expect(JSON.parse(response.body)[0]["id"]).to eq(container3.id)
      expect(JSON.parse(response.body)[0]["filtered_activity"]["id"]).to eq(activity4.id)
      expect(JSON.parse(response.body)[0]["filtered_activity"]["activity_status"]).to eq(activity4.activity_status)
    end
  end

  describe "POST /create" do
    it 'returns a successful response' do
      post "/api/v1/container_management/containers",params: params ,headers: valid_header
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT /update" do
    it 'returns a successful response' do
      put "/api/v1/container_management/containers/#{container.id}",params: update_params ,headers: valid_header
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it 'returns a successful response' do
      get "/api/v1/container_management/containers/#{container.id}",headers: valid_header
      expect(response).to have_http_status(:success)
      # puts response.body
    end
  end


end

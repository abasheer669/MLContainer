# spec/support/bearer_token_helper.rb

require 'json'
require 'httparty'



module BearerTokenHelper
  def fetch_bearer_token(email, password)
    post '/api/v1/user_management/login', params: {grant_type:"password", email: email, password: password }

    parsed_response = JSON.parse(response.body)
    access_token = parsed_response['token']['access_token']
    { 'Authorization' => "Bearer #{access_token}" }
  end



end

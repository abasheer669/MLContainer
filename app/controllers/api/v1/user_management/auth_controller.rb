class Api::V1::UserManagement::AuthController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[login]

  def login

    if params[:grant_type] == "refresh_token"
      access_token = Doorkeeper::AccessToken.find_by(refresh_token: params[:refresh_token])
      if access_token
        user_id = access_token.resource_owner_id
        access_token.destroy
      else
        render json: { error: "Invalid Access Token" }, status: :unauthorized
        return
      end

      access_token = Doorkeeper::AccessToken.create(
        resource_owner_id: user_id,
        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
        refresh_token: params[:refresh_token]
      )

      token={
        token_type: "Bearer",
        access_token: access_token.token,
        refresh_token: access_token.refresh_token,
        expires_in: access_token.expires_in
      }


      render json: { token: token}, status: :ok

    elsif params[:grant_type] == "password"

      @user = User.find_by(email: params[:email])

      if @user && @user.valid_password?(params[:password])

        access_token = Doorkeeper::AccessToken.create(
          resource_owner_id: @user.id,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
          refresh_token: generate_refresh_token
        )
        #debugger
        token={
          token_type: "Bearer",
          access_token: access_token.token,
          refresh_token: access_token.refresh_token,
          expires_in: access_token.expires_in
        }
        # debugger
        render json: { token: token}, status: :ok
      else
        render json: { error: "Invalid Credentials" }, status: :unauthorized
      end
    end
  end

  def update_password
    # current_user = params[:access_token].resource_owner
      User.find(current_user.id).reset_password(params[:password], params[:confirm_password])
      render json:{ message: current_user.id },status: :ok

  end


  def destroy

    authorization_header = request.headers['Authorization']
    if authorization_header && authorization_header.start_with?('Bearer ')
      access_token = authorization_header.gsub('Bearer ', '')
    else
      render json: {message: "No Auth header found"}
    end

    # access_token = Doorkeeper::AccessToken.find_by!(token: params[:access_token])
    # access_token.destroy
    Doorkeeper::AccessToken.revoke_all_for(current_user, application: doorkeeper_token.application)


    render json: { message: 'Logged out successfully' }, status: :ok
  end

  private

  def generate_refresh_token
    loop do
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end

  def password_params
    params.require(:password).permit(:password, :confirm_password)
  end

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end

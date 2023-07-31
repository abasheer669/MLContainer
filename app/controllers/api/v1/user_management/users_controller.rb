class Api::V1::UserManagement::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def index
    if params[:name].present?
      @users = User.where(name: params[:name], user_type: params[:role])
    else
      @users = User.where(user_type: params[:role])
    end
    render json: @users, root: "users", each_serializer: UserSerializer
  end

  def show
    render json: @user, serializer: UserSerializer
  end

  def create
    @user = User.create!(user_params)
    render json: @user, serializer: UserSerializer, status: :created
  end

  def update_profile

    if current_user.update(edit_profile_params)
      render staus: :ok
    else
      render status: :unprocessable_entity
    end

  end

  def update
    @role = params[:role]
    if @user.nil?
      render status: :not_found
    elsif @user.user_type == @role
      if @user.update(update_user_params)
        render staus: :ok
      else
        render status: :unprocessable_entity
      end
    else
      render json: { error: "User does not have the required role" }, status: :forbidden
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name , :user_status , :user_type, :phone_number)
  end

  def update_user_params
    params.require(:user).permit(:email, :password, :name , :user_status , :phone_number)
  end

  def edit_profile_params
    params.require(:user).permit(:email, :name , :phone_number)
  end

  def set_user
    @user = User.find(params[:id])
  end

end

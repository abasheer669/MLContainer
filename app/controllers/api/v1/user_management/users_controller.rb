class Api::V1::UserManagement::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def index

    if params[:name].present? and params[:name]!= nil
      @users = User.where(name: params[:name], user_type: params[:role])
    else
      @users = User.where(user_type: params[:role])
    end

    if @users.empty?
      render json: { message: 'No users found for the given search criteria' }, status: :ok
    else
      render json: @users, each_serializer: UserSerializer, root: "users"
    end

  end

  def show
    render json: @user, serializer: UserSerializer
  end

  def create

    begin
      @user = User.new(user_params)
      if  User.exists?(email: @user.email)
        raise StandardError,'User with this email already exists'
      elsif @user.save
        render json: @user, serializer: UserSerializer, status: :created
      else
        render json: { errors: @user.errors }, status: :unprocessable_entity
      end

    rescue RuntimeError => e
     render json: { errors:   e.message}, status: :unprocessable_entity
    rescue StandardError => e
      render json: { errors:   e.message}, status: :unprocessable_entity
    end
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
    required_fields = [:name, :email, :password, :user_status , :user_type, :phone_number]

    if params[:user].present?
      missing_fields = required_fields - params[:user].keys.map(&:to_sym)
      if missing_fields.any?
        #puts missing_fields
        raise "missing_fields"
        # render json: { error: "Missing required fields" }, status: :unprocessable_entity
      else
        params.require(:user).permit(:email, :password, :name , :user_status , :user_type, :phone_number)
      end
    else
      raise "No input provided"
      # render json: { error: 'No input provided' }, status: :unprocessable_entity
    end

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

class Api::V1::CustomerManagement::CustomersController < ApplicationController
  class Api::V1::CustomerManagement::CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :update, :destroy]

    def index
      @customer = Customer.all
      if params[:search].present?
          @customer = @customer.where(name: params[:search])
      end
      render json: @customer, Serializer:CustomerSerializer, status: :ok
    end

    def show
      render json: @customer,Serializer:CustomerSerializer, status: :ok
    end

    def create
      if customer.create!(customer_params)
        render json: customer,Serializer:CustomerSerializer, status: :created
      else
        render json: customer.errors, status: :unprocessable_entity
      end
    end

    def update
      if @customer.update(customer_params)
        render json: @customer,Serializer:CustomerSerializer
      else
        render json: @customer.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @customer.destroy
      head :no_content
    end

    private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(
        :name, :email, :owner_name, :billing_name, :hourly_rate, :gst,
        :pst, :city, :province, :postalcode, :customer_type, :password,
        :customer_status
  )
    end
  end

end

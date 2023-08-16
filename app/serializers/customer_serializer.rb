class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :owner_name, :billing_name, :hourly_rate, :customer_status
end

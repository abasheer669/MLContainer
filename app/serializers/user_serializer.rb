class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_number, :user_type, :user_status
end

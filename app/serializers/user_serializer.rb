class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone_number, :user_type, :user_status
end

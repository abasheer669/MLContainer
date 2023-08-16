class ActivitySerializer < ActiveModel::Serializer
  attributes :id ,:activity_type, :activity_date, :activity_status
  # has_many :items



end

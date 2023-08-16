class ShowContainerSerializer < ActiveModel::Serializer
  attributes :id, :yardname_id, :submitter_initial, :container_height_id,
             :container_length_id, :container_number,  :container_type,
             :customer_id, :manufacture_year,
             :container_owner_name
  has_many :activities
  has_many :comments

end

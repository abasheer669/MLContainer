class LogSerializer < ActiveModel::Serializer

  attributes :id, :user_id, :activity_id, :log_status, :created_at
  belongs_to :activity

end

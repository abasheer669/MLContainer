class LatestActivitySerializer < ActiveModel::Serializer
  attributes :activity_id, :activity_type, :activity_date, :activity_status


  def activity_id
    object&.activity_id || nil
  end

  def activity_type
    object&.activity_type || 'idle'
  end

  def activity_date
    object&.activity_date || nil
  end

  def activity_status
    object&.activity_status || nil
  end
end

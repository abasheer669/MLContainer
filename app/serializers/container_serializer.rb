class ContainerSerializer < ActiveModel::Serializer
  attributes :id, :container_owner_name ,:container_number, :yardname, :customer

  def yardname
    object.yardname.yard_name
  end

  def customer
    object.customer.name
  end

  has_one :filtered_activity , serializer: ActivitySerializer

  def filtered_activity

    if @instance_options[:option_name] == "all"
      activity = Activity.where(container_id: object.id).order(created_at: :desc).first
      # puts activity
    elsif @instance_options[:option_name] == "draft"
      activity =  Activity.where(activity_status: [:quote_draft, :inspection_draft, :repair_draft]).order(created_at: :desc).first
    elsif @instance_options[:option_name] == "admin_review"
      activity =  Activity.where(container_id: object.id, activity_status: [:quote_pending, :repair_done, :inspection_done]).order(created_at: :desc).first
    elsif @instance_options[:option_name] == "customer_pending"
      activity = Activity.where(container_id: object.id, activity_status: [:quote_issued]).order(created_at: :desc).first
    elsif @instance_options[:option_name] == "customer_approved"
      activity = Activity.where(container_id: object.id, activity_status: [:quote_approved]).order(created_at: :desc).first
    end

    if @instance_options[:activity_date].present?
      # puts activity.activity_date
      # puts @instance_options[:activity_date]
      if activity.activity_date == Date.parse(@instance_options[:activity_date])
        activity = activity
      elsif
        activity = nil
      end

    end

    if activity.present? && @instance_options[:activity_status].present?
      # debugger
      # activity = activity.where(activity_status: @instance_options[:activity_status])
      if activity.activity_status == @instance_options[:activity_status]
        activity = activity
      elsif
        activity = nil
      end

    end

    if activity.present? && @instance_options[:sort_attribute].present?

      activities_relation = Activity.where(id: activity.id)
      activities_relation = activities_relation.order(Arel.sql("#{@instance_options[:sort_attribute]} #{@instance_options[:sort_order]}"))
      activity = activities_relation.first
      # activity = activity.order(Arel.sql("#{@instance_options[:sort_attribute]} #{@instance_options[:sort_order]}"))
    end

    activity

  end
  # def latest_activity
  #   act  = Activity.where(container_id: object.id).order(created_at: :desc).first
  #   if act.present?
  #     {
  #       activity_id: act.id,
  #       activity_type: act.activity_type,
  #       activity_date: act.activity_date,
  #       activity_status: act.activity_status,
  #       user_id: act.user_id,
  #       total_cost: act.total_cost,
  #       activity_created_at: act.created_at,
  #       activity_updated_at: act.updated_at
  #     }
  #   else
  #     {
  #       activity_id: nil,
  #       activity_type: nil,
  #       activity_date: nil,
  #       activity_status: 'idle',
  #       user_id: nil,
  #       total_cost: nil,
  #       activity_created_at: nil,
  #       activity_updated_at: nil
  #     }
  #   end
  # end

end

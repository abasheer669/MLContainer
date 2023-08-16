class Api::V1::ContainerManagement::ActivityController < ApplicationController
  #before_action :set_default_activity_status, only: :create

  def create
    activity_type = params[:activity][:activity_type]

    activity_status = set_default_activity_status(activity_type)

    @activity = Activity.create!(
      container_id: params[:container_id],
      user_id: current_user.id,
      activity_type: activity_type ,
      activity_status: activity_status,
      activity_date: params[:activity][:activity_date]
    )

    @activity.logs.create!(user_id: current_user.id, log_status: "created" )
    render json: @activity , status: :created
  end

  def show

    @activity = Activity.where(id: params[:id])
    render json: @activity, status: :ok

  end

  def index
    @activities = Activity.where(container_id: params[:container_id])
    render json: @activities, Serializer:ActivitySerializer,  status: :ok
  end

  def change_status
    @activity = Activity.find(params[:activity_id])
    @activity.update(activity_status: params[:activity_status])
    @activity.logs.create!(user_id: current_user.id, log_status: params[:activity_status]  )
    render json: @activity, status: :ok
  end


  private

  def activity_params
    params.require(:activity).permit(:activity_type, :activity_date)
  end

  def set_default_activity_status(activity_type)
    case activity_type
    when "quote_form"
      :quote_draft
    when "inspection_form"
      :inspection_draft
    when "repair_form"
      :repair_draft
    else
      :idle
    end
  end


end

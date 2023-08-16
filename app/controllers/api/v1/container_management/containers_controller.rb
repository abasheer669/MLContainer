class Api::V1::ContainerManagement::ContainersController < ApplicationController

  def index

    if params[:activity] == "all"
      @containers = Container.all
    elsif params[:activity] == "draft"
      @containers = Container.left_outer_joins(:activities)
      .where(activities: { activity_status:  [:quote_draft, :insepection_draft, :repair_draft]})
    elsif params[:activity] == "admin_review"
      @containers = Container.left_outer_joins(:activities)
      .where(activities: { activity_status: [:quote_pending, :repair_done, :inspection_done] })
    elsif params[:activity] == "customer_pending"
      @containers= Container.left_outer_joins(:activities)
      .where(activities: { activity_status: [:quote_issued] })
    elsif params[:activity] == "customer_approved"
      @containers = Container.left_outer_joins(:activities)
      .where(activities: { activity_status: [:quote_approved] })
    else
      render json: { error: "invalid argument" }, status: :unprocessable_entity
      return
    end

    if params[:search]
      @containers = @containers.where(container_number: params[:search])
      if @containers.empty?
        render json: { error: "No containers found for the given search criteria" }, status: :not_found
         return
      end
    end

    if params[:activity_date]
      # puts params[:activity_date]
      @containers = @containers.joins(:activities).where( activities: { activity_date: params[:activity_date] })
    end

    if params[:activity_status]
      @containers = @containers.joins(:activities).where(activities: { activity_status: params[:activity_status] })
    end

    if params[:yardname]
      yardname = Yardname.find_by(yard_name: params[:yardname])
      @containers = @containers = @containers.where(yardname_id: yardname.id)
    end

    if params[:customer_name]
      customer = Customer.find_by(name: params[:customer_name])
      @containers = @containers = @containers.where(customer_id: customer.id)
    end


    if params[:sort_attribute]
      sort_attribute = params[:sort_attribute]
      sort_order = params[:sort_order] || 'ASC'

      if sort_attribute == "customer_name"
        @containers = @containers.joins(:customer).order(Arel.sql("customers.name #{sort_order}"))
      elsif sort_attribute == "yardname"
        @containers = @containers.joins(:yardname).order(Arel.sql("yardnames.yard_name #{sort_order}"))
      elsif sort_attribute == "container_owner_name"
        @containers = @containers.order(Arel.sql("#{sort_attribute} #{sort_order}"))
      elsif sort_attribute == "activity_date" || sort_attribute == "activity_status"
        @containers = @containers.joins(:activities).order(Arel.sql("activities.#{sort_attribute} #{sort_order}"))
      else
        render json: { error: "Invalid sort attribute" }, status: :unprocessable_entity
        return
      end
    end

  @sort_attribute = @sort_attribute || nil
  @sort_order = @sort_order || nil
  @activity_date = params[:activity_date] || nil
  @activity_status = params[:activity_status] || nil


  # puts @containers
  # puts "gggggg"
  # puts Date.parse(params[:activity_date])

  render json: @containers, each_serializer: ContainerSerializer , activity_status: @activity_status, sort_attribute: @sort_attribute, sort_order: @sort_order, activity_date: @activity_date ,  option_name: params[:activity] , status: :ok
  end

  def show
    @container = Container.find(params[:id])
    render json: @container, serializer: ShowContainerSerializer ,status: :ok
  end

  def show_logs
    @container = Container.find(params[:id])
    @activity_ids = @container.activities.pluck(:id)
    @logs = Log.where(activity_id: @activity_ids)

    render json: @logs, Serializer:LogSerializer, status: :ok

  end

  def show_comments
    @container = Container.find(params[:id])
    @activity_ids = @container.activities.pluck(:id)
    @items_with_matching_activities = Item.where(activity_id: @activity_ids)

    @comments = @items_with_matching_activities.pluck(:comment)
    @container_comments = @container.comments.pluck(:comment)

    render json: @comments+@container_comments, status: :ok

  end


  def create
    @container = Container.create!(container_params.except(:comment, :left_side, :right_side, :front_side, :interior, :under_side, :roof))
    attachments_data = [
       { file_type: "left_side", pre_signed_url: container_params[:left_side] },
      { file_type: "right_side", pre_signed_url: container_params[:right_side] },
      { file_type: "roof", pre_signed_url: container_params[:roof] },
      { file_type: "front_side", pre_signed_url: container_params[:front_side] },
      { file_type: "under_side", pre_signed_url: container_params[:under_side] },
      { file_type: "interior", pre_signed_url: container_params[:under_side]}
    ]
    @container.attachments.create!(attachments_data)
    @container.comments.create!({comment: container_params[:comment], user_id: current_user.id})

    render json: { message: "Container created successfully" }, status: :created

  end

  def update
    @container = Container.find(params[:id])
    if @container.update(container_params.except(:comment, :left_side, :right_side, :front_side, :interior, :under_side, :roof))
      attachments_data = [
         { file_type: "left_side", pre_signed_url: container_params[:left_side] },
        { file_type: "right_side", pre_signed_url: container_params[:right_side] },
        { file_type: "roof", pre_signed_url: container_params[:roof] },
        { file_type: "front_side", pre_signed_url: container_params[:front_side] },
        { file_type: "under_side", pre_signed_url: container_params[:under_side] },
        { file_type: "interior", pre_signed_url: container_params[:under_side],}
      ]
      @container.attachments.destroy_all # Remove existing attachments if needed
      @container.attachments.create!(attachments_data) # Add the new attachments

      @container.comments.create!({comment: container_params[:comment], user_id: current_user.id})

      render json: { message: "Container updated successfully" }, status: :ok
    else
      render json: { errors: @container.errors.full_messages }, status: :unprocessable_entity
    end
  end



  private

  def latest_activity_subquery
    subquery = Activity.select("MAX(updated_at) as latest_updated_at, container_id").group(:container_id)

    Activity.from(subquery)
  end
  def container_params
    params.require(:container).permit(
      :yardname_id, :container_number, :customer_id, :container_owner_name, :submitter_initial,
      :container_length_id, :container_height_id, :container_type, :manufacture_year, :location,
      :comment, :left_side, :right_side, :front_side, :interior, :under_side, :roof
    )
  end


end

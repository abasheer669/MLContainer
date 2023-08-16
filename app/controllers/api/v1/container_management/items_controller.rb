class Api::V1::ContainerManagement::ItemsController < ApplicationController

  def create

    activity = Activity.find(params[:activity_id])
    @item = activity.items.create!(item_params.except(:damage_area_picture, :repair_area_picture))
    attachments_data = [
    { file_type: "damage_area", pre_signed_url: item_params[:damage_area_picture] },
    { file_type: "repair_area", pre_signed_url: item_params[:repair_area_picture] }]
    @item.attachments.create!(attachments_data)
    @item.comments.create!({comment: container_params[:comment], user_id: current_user.id})

    render json: { message: "item added successfully" }, status: :created

  end


  def edit
    item = Item.find(params[:id])
    if item.update(item_params.except(:damage_area_picture, :repair_area_picture))

      attachments_data = [
        { file_type: "damage_area", pre_signed_url: item_params[:damage_area_picture] },
        { file_type: "repair_area", pre_signed_url: item_params[:repair_area_picture] }
      ]
      item.attachments.destroy_all # Remove existing attachments if needed
      item.attachments.create!(attachments_data) # Add the new attachments
      render json: { message: "Item updated successfully" }, status: :ok
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    render json: { message: "Item deleted successfully" }, status: :ok
  end

  private

  def item_params
    params.require(:item).permit(
      :repair_id,
      :damage_area,
      :comment,
      :quantity,
      :location,
      :container_type,
      :container_repair_area,
      :damage_area_picture,
      :repair_area_picture
    )
  end

end

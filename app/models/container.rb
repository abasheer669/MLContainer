class Container < ApplicationRecord
  belongs_to :yardname
  belongs_to :container_height
  belongs_to :container_length
  belongs_to :customer
  has_many :activities
  has_many :comments,  as: :commentable
  has_many :attachments, as: :attachable
  enum container_type: [:cold , :normal]

  def latest_activity
    activities.order(created_at: :desc).first
  end

  # def filtered_activities
  #   debugger
  #   if @instance_options[:option_name] == "draft"
  #     activities.where(activity_status: [:quote_draft, :inspection_draft, :repair_draft])
  #   elsif @instance_options[:option_name] == "admin_review"
  #     activities.where(activity_status: [:quote_pending, :repair_done, :inspection_done])
  #   else
  #     activities
  #   end
  # end

end

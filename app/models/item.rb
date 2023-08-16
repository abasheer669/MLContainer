class Item < ApplicationRecord
  belongs_to :activity
  enum container_type: [:cold, :normal]
  enum container_repair_area: [:left ,:right, :top ,:interior]
  enum damage_area:  [:door ,:roof, :handle]

end

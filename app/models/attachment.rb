class Attachment < ApplicationRecord
  #enum attachable_type: { container: "Container", item: "Item" }

  enum file_type: {
    left_side: "left_side",
    right_side: "right_side",
    roof: "roof",
    under_side: "under_side",
    interior: "interior",
    front_side: "front_side",
    damage_area: "damage_area",
    repair_area: "repair_area"

  }

  belongs_to :attachable, polymorphic: true
end

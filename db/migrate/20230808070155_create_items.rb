class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :damage_area
      t.text :comment
      t.float :quantity
      t.float :labour_cost
      t.float :material_cost
      t.float :total_cost
      t.string :location
      t.string :container_type
      t.string :container_repair_area
      t.integer :repair_id

      t.timestamps
    end
  end
end

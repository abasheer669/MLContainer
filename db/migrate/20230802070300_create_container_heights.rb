class CreateContainerHeights < ActiveRecord::Migration[7.0]
  def change
    create_table :container_heights do |t|
      t.integer :height

      t.timestamps
    end
  end
end

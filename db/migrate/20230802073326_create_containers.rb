class CreateContainers < ActiveRecord::Migration[7.0]
  def change
    create_table :containers do |t|
      t.references :yardname, null: false, foreign_key: true
      t.string :submitter_initial
      t.references :container_height, null: false, foreign_key: true
      t.references :container_length, null: false, foreign_key: true
      t.string :name
      t.string :location
      t.integer :container_type
      t.references :customer, null: false, foreign_key: true
      t.integer :manufacture_year

      t.timestamps
    end
  end
end

class CreateContainerLengths < ActiveRecord::Migration[7.0]
  def change
    create_table :container_lengths do |t|
      t.integer :length

      t.timestamps
    end
  end
end

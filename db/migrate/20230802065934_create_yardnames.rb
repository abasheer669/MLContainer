class CreateYardnames < ActiveRecord::Migration[7.0]
  def change
    create_table :yardnames do |t|
      t.string :yard_name

      t.timestamps
    end
  end
end

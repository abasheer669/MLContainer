class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :container, null: false, foreign_key: true
      t.integer :activity_type
      t.integer :activity_status
      t.references :user, null: false, foreign_key: true
      t.float :total_cost

      t.timestamps
    end
  end
end

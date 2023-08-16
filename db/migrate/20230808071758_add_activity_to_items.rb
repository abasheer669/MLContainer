class AddActivityToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :activity, null: false, foreign_key: true
  end
end

class AddActivityDateToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :activity_date, :date
  end
end

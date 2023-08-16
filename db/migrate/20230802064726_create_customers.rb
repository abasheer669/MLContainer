class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :owner_name
      t.string :billing_name
      t.float :hourly_rate
      t.float :gst
      t.float :pst
      t.string :city
      t.string :province
      t.string :postalcode
      t.integer:customer_type
      t.string :password
      t.integer :customer_status

      t.timestamps
    end
  end
end

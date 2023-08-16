class AddContainerOwnerNameToContainers < ActiveRecord::Migration[7.0]
  def change
    add_column :containers, :container_owner_name, :string
  end
end

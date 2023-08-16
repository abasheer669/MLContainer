class RenameNameToContainerNumberInContainers < ActiveRecord::Migration[7.0]
  def change
      rename_column :containers, :name, :container_number
  end
end

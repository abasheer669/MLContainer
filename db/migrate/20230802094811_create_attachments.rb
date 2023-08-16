class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.string :file_type
      t.references :attachable, polymorphic: true, null: false
      t.string :pre_signed_url

      t.timestamps
    end
  end
end

class CreateLocalStorages < ActiveRecord::Migration[5.1]
  def change
    create_table :local_storages do |t|
      t.text :token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

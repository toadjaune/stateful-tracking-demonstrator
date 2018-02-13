class CreateEtags < ActiveRecord::Migration[5.1]
  def change
    create_table :etags do |t|
      t.belongs_to :user, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end

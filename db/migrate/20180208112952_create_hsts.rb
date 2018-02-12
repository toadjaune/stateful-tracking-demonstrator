class CreateHsts < ActiveRecord::Migration[5.1]
  def change
    create_table :hsts do |t|
      t.belongs_to :user, foreign_key: true
      t.string :token_set

      t.timestamps
    end
  end
end

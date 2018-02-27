class CreateHpkps < ActiveRecord::Migration[5.1]
  def change
    create_table :hpkps do |t|
      t.belongs_to :user, foreign_key: true
      t.string :token
      
      t.timestamps
    end
  end
end

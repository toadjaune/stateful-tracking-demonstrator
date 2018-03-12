class CreateRedirections < ActiveRecord::Migration[5.1]
  def change
    create_table :redirections do |t|
      t.belongs_to :user, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end

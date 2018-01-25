class CreateFirstPartyCookies < ActiveRecord::Migration[5.1]
  def change
    create_table :first_party_cookies do |t|
      t.string :token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

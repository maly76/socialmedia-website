class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :username
      t.boolean :onlyForFriends
      t.string :imageurl

      t.timestamps
    end
  end
end

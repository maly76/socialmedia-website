class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :friend, null: false, foreign_key: false

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end

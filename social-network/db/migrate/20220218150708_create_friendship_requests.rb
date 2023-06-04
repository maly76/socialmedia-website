class CreateFriendshipRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friendship_requests do |t|
      t.belongs_to :from_user, null: false, foreign_key: false
      t.belongs_to :to_user, null: false, foreign_key: false

      t.timestamps
    end
    add_foreign_key :friendship_requests, :users, column: :from_user_id
    add_foreign_key :friendship_requests, :users, column: :to_user
  end
end

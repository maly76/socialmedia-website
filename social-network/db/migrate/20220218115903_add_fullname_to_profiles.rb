class AddFullnameToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :fullname, :string
  end
end

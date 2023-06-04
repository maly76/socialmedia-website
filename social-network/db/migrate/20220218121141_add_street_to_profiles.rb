class AddStreetToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :street, :string
  end
end

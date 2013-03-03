class AddUserAttributes < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :bio, :string
    add_column :users, :status, :string
    # Rely on Geocoder instead of PostGIS and spatial queries.
    add_column :users, :location, :string
  end
end

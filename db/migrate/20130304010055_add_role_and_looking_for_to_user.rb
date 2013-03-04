class AddRoleAndLookingForToUser < ActiveRecord::Migration
  def change
    add_column :users, :looking_for, :string
    add_column :users, :role, :string
  end
end

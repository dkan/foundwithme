class AddUserIdToEmploymentsAndEducation < ActiveRecord::Migration
  def change
    add_column :employments, :user_id, :integer
    add_column :educations, :user_id, :integer
  end
end

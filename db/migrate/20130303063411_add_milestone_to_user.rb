class AddMilestoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :milestone, :string
  end
end

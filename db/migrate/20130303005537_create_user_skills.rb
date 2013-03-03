class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.integer :user_id, unique: true
      t.integer :skill_id, unique: true

      t.timestamps
    end
  end
end

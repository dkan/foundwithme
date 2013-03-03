class CreateUserInterests < ActiveRecord::Migration
  def change
    create_table :user_interests do |t|
      t.integer :user_id, unique: true
      t.integer :interest_id, unique: true

      t.timestamps
    end
  end
end

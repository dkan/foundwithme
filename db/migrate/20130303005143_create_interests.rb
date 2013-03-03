class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name

      t.timestamps
    end

    add_index :interests, :name, unique: true
  end
end

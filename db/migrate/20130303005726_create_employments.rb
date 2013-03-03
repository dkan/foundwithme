class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.date :start_date
      t.date :end_date
      t.string :company
      t.string :title

      t.timestamps
    end
  end
end

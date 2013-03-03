class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.date :start_date
      t.date :end_date
      t.string :institution
      t.string :degree

      t.timestamps
    end
  end
end

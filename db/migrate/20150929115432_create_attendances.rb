class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.text :description
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end

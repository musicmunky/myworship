class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.date :schedule_date
      t.text :notes

      t.timestamps null: false
    end
  end
end

class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :notification_type
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end

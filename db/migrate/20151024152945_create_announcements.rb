class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :heading
      t.text :message
      t.boolean :is_active
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

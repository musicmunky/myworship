class CreateAnnouncementTypes < ActiveRecord::Migration
  def change
    create_table :announcement_types do |t|
      t.string :type_name
      t.integer :type_level

      t.timestamps null: false
    end
  end
end

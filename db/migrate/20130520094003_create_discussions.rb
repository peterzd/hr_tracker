class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.text :content
      t.boolean :is_visible
      t.references :salary_activity

      t.timestamps
    end
    add_index :discussions, :salary_activity_id
  end
end

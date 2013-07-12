class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.references :employee
      t.references :creator

      t.timestamps
    end
    add_index :notes, :employee_id
    add_index :notes, :creator_id
  end
end

class CreateBonus < ActiveRecord::Migration
  def change
    create_table :bonuses do |t|
      t.float :amount
      t.date :distribution_date
      t.text :comment
      t.references :employee

      t.timestamps
    end
    add_index :bonuses, :employee_id
  end
end

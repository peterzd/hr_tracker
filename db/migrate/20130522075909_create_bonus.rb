class CreateBonus < ActiveRecord::Migration
  def change
    create_table :bonus do |t|
      t.float :amount
      t.date :distribution_date
      t.text :comment
      t.references :employee

      t.timestamps
    end
    add_index :bonus, :employee_id
  end
end

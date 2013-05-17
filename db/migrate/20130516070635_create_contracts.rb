class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.date :start_date
      t.date :end_date
      t.float :salary
      t.references :employee

      t.timestamps
    end
    add_index :contracts, :employee_id
  end
end

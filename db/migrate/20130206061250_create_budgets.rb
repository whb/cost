class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.integer :category_id
      t.integer :period_id
      t.decimal :amount

      t.timestamps
    end
  end
end

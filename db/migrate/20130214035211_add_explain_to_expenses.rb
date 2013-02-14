class AddExplainToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :explain, :text
  end
end

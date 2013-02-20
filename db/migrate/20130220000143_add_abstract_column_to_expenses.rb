class AddAbstractColumnToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :abstract, :string
  end
end

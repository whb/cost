class RenameExpenseNoToSn < ActiveRecord::Migration
  def up
    rename_column :expenses, :no, :sn
  end

  def down
  end
end

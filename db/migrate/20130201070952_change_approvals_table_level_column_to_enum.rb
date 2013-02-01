class ChangeApprovalsTableLevelColumnToEnum < ActiveRecord::Migration
  def up
    change_column :approvals, :level, :string
  end

  def down
    change_column :approvals, :level, :integer
  end
end

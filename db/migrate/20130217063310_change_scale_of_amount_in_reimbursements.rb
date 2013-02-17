class ChangeScaleOfAmountInReimbursements < ActiveRecord::Migration
  def up
    change_column :reimbursements, :amount, :decimal, :precision => 10, :scale => 2
  end

  def down
  end
end

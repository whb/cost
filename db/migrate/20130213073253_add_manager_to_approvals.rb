class AddManagerToApprovals < ActiveRecord::Migration
  def change
    add_column :approvals, :manager, :string
  end
end

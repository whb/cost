class AddOrganizationIdToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :organization_id, :integer
  end
end

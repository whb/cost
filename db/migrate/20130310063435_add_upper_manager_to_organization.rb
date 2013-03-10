class AddUpperManagerToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :upper_manager_id, :integer
  end
end

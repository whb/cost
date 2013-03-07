class AddKindColumnToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :kind, :string
  end
end

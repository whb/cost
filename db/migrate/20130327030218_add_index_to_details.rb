class AddIndexToDetails < ActiveRecord::Migration
  def change
    add_index :details, :reimbursement_id
    add_index :details, :category_id
  end
end

class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.integer :expense_id
      t.integer :level
      t.date :approve_on
      t.boolean :agree
      t.string :explain

      t.timestamps
    end
  end
end

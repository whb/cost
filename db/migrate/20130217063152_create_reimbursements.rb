class CreateReimbursements < ActiveRecord::Migration
  def change
    create_table :reimbursements do |t|
      t.string :sn
      t.date :reimburse_on
      t.string :staff
      t.string :status
      t.integer :organization_id
      t.string :abstract
      t.decimal :amount
      t.integer :expense_id
      t.string :invoice_no

      t.timestamps
    end
  end
end

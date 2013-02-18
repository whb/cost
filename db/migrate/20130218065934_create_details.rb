class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.integer :reimbursement_id
      t.integer :category_id
      t.string :name
      t.integer :amount
      t.string :unit
      t.decimal :unit_price, :precision => 10, :scale => 2
      t.decimal :price, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end

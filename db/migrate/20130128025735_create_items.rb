class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :expense_id
      t.string :category
      t.string :name
      t.integer :amount
      t.string :unit
      t.decimal :unit_price
      t.decimal :price

      t.timestamps
    end
  end
end

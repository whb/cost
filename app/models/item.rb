class Item < ActiveRecord::Base
	belongs_to :expense
  attr_accessible :amount, :category, :expense_id, :name, :price, :unit, :unit_price

end

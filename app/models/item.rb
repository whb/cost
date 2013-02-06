class Item < ActiveRecord::Base
	belongs_to :expense
  belongs_to :category
  attr_accessible :amount, :category_id, :expense_id, :name, :price, :unit, :unit_price
  validates_presence_of :amount
end

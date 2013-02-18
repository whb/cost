class Detail < ActiveRecord::Base
  belongs_to :reimbursement
  belongs_to :category
  attr_accessible :amount, :category_id, :name, :price, :reimbursement_id, :unit, :unit_price
  validates_presence_of :category_id, :name, :price
end

class Budget < ActiveRecord::Base
  belongs_to :period
  belongs_to :category
  attr_accessible :amount, :period_id, :category_id
  validates_presence_of :amount, :period_id, :category_id
end

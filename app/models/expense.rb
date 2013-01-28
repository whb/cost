class Expense < ActiveRecord::Base
	has_many :items, :dependent => :destroy
	accepts_nested_attributes_for :items
	
  attr_accessible :no, :request_on, :staff
end

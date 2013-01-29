class Expense < ActiveRecord::Base
	has_many :items, :dependent => :destroy
	accepts_nested_attributes_for :items, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
	
  attr_accessible :no, :request_on, :staff, :items_attributes
end

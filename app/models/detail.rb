class Detail < ActiveRecord::Base
  belongs_to :reimbursement
  belongs_to :category
  attr_accessible :amount, :category_id, :name, :price, :reimbursement_id, :unit, :unit_price
  validates_presence_of :category_id, :name, :price

  scope :committed, :joins => :reimbursement, :conditions => "status = 'commit'"
  scope :year, lambda { |year| { :joins => :reimbursement, :conditions => ["YEAR(reimburse_on) = #{year}"] } }

  def copy(item) 
    self.category_id = item.category_id
    self.name = item.name
    self.unit = item.unit
    self.unit_price = item.unit_price
    self.price = item.price
  end
end

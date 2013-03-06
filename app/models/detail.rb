class Detail < ActiveRecord::Base
  belongs_to :reimbursement
  belongs_to :category
  attr_accessible :amount, :category_id, :name, :price, :reimbursement_id, :unit, :unit_price
  validates_presence_of :category_id, :name, :price

  scope :committed, :joins => :reimbursement, :conditions => "status = 'commit'"
  scope :year, lambda { |year| { :joins => :reimbursement, :conditions => ["YEAR(reimburse_on) = #{year}"] } }
  scope :this_year, :joins => :reimbursement, :conditions => "YEAR(reimburse_on) = #{Date.today.year}"
  scope :interval, lambda { |interval| joins(:reimbursement).where('reimbursements.reimburse_on' => interval) }
  scope :belongs_to_category, lambda { |category_id| where(:category_id => category_id) }
  scope :belongs_to_organization, lambda { |organization_id| joins(:reimbursement).where({'reimbursements.organization_id' => organization_id})}

  def copy(item)
    self.category_id = item.category_id
    self.name = item.name
    self.amount = item.amount
    self.unit = item.unit
    self.unit_price = item.unit_price
    self.price = item.price
  end
end

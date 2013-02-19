class Reimbursement < ActiveRecord::Base
  has_many :details, :dependent => :destroy
  accepts_nested_attributes_for :details, :allow_destroy => true,
    :reject_if => lambda { |a| a[:category_id].blank? and a[:name].blank? and a[:amount].blank? and a[:unit].blank? and a[:unit_price].blank? and a[:price].blank?}
  belongs_to :organization
  belongs_to :expense
  attr_accessible :abstract, :amount, :expense_id, :invoice_no, :organization_id, :reimburse_on, :sn, :staff, :details_attributes
  validates_presence_of :sn, :reimburse_on, :staff, :organization, :abstract, :amount, :details
  validates_uniqueness_of :sn

  STATUS_TYPES = {
    :edit => "Edit",
    :commit => "Commit",
  }
  enum :status, STATUS_TYPES

  def self.new_blank(current_user)
    reimbursement = Reimbursement.new
    reimbursement.sn = generate_sn
    if current_user
      reimbursement.organization = current_user.organization
      reimbursement.staff = current_user.displayname
    else
      reimbursement.organization = Organization.default
    end
    reimbursement.reimburse_on = Time.now.to_date
    1.times { reimbursement.details.build }
    reimbursement
  end

  def self.generate_sn
    max_id = Reimbursement.maximum('id') ? Reimbursement.maximum('id') : 0
    "VCH-%.6d" % (max_id + 1)
  end

  def category_price(category_id)
    sum_category_price = 0
    details.each do |detail|
      sum_category_price += detail.price if (category_id == detail.category_id and detail.price != nil)
    end
    sum_category_price
  end

  def has_category?(category_id)
    details.each do |detail|
      return true if category_id == detail.category_id
    end
    return false
  end
end

class Reimbursement < ActiveRecord::Base
  belongs_to :organization
  belongs_to :expense
  attr_accessible :abstract, :amount, :expense_id, :invoice_no, :organization_id, :reimburse_on, :sn, :staff
  validates_presence_of :sn, :reimburse_on, :staff, :organization, :abstract, :amount
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
    
    reimbursement
  end

  def self.generate_sn
    max_id = Reimbursement.maximum('id') ? Reimbursement.maximum('id') : 0
    "VCH-%.6d" % (max_id + 1)
  end
end

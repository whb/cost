class Reimbursement < ActiveRecord::Base
  attr_accessible :abstract, :amount, :expense_id, :invoice_no, :organization_id, :reimburse_on, :sn, :staff, :status
end

class Approval < ActiveRecord::Base
  attr_accessible :agree, :approve_on, :expense_id, :explain, :level
end

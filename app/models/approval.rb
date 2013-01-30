class Approval < ActiveRecord::Base
  belongs_to :expense
  attr_accessible :agree, :approve_on, :expense_id, :explain, :level
end

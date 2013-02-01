#encoding:utf-8

class Approval < ActiveRecord::Base
  belongs_to :expense
  attr_accessible :agree, :approve_on, :expense_id, :explain, :level

  LEVEL_TYPES = {
    :manager_approval => "主管经理审批",
    :general_manager_approval => "总经理审批",
  }
  enum :level, LEVEL_TYPES
end

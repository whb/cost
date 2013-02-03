#encoding:utf-8

class Approval < ActiveRecord::Base
  belongs_to :expense
  attr_accessible :agree, :approve_on, :expense_id, :explain, :level

  LEVEL_TYPES = {
    :manager_approval => "主管经理审批",
    :general_manager_approval => "总经理审批",
  }
  enum :level, LEVEL_TYPES

  def commit!
    transaction do
      expense = self.expense
      if self.agree
        self.level == :manager_approval ? expense.manager_approve : expense.general_manager_approve
      else
        expense.refuse
      end

      expense.save
      save
    end
  end
end

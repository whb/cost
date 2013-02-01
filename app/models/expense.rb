class Expense < ActiveRecord::Base
	has_many :items, :dependent => :destroy
	accepts_nested_attributes_for :items, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  has_many :approvals
	
  attr_accessible :no, :request_on, :staff, :items_attributes

  STATUS_TYPES = {
    :edit => "Edit",
    :commit => "Commit",
    :manager_approval => "Manager Approval",
    :general_manager_approval => "General Manager Approval",
  }
  enum :status, STATUS_TYPES

  def self.new_blank
    expense = Expense.new
    3.times { expense.items.build }
    expense
  end

  def editable?
    status == :edit
  end

  def refuse
    status = :edit
  end

  def manager_approve
    status = :manager_approval
  end

  def general_manager_approve
    status = :general_manager_approval
  end
end

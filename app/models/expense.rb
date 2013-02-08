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

  scope :activing, where(:status => [:edit, :commit, :manager_approval])

  def self.new_blank
    expense = Expense.new
    expense.request_on = Time.now.to_date
    3.times { expense.items.build }
    expense
  end

  def editable?
    self.status == :edit
  end

  def refuse
    self.status = :edit
  end

  def manager_approve
    self.status = :manager_approval
  end

  def general_manager_approve
    self.status = :general_manager_approval
  end

  def category_price(category_id) 
    sum_category_price = 0
    items.each do |item|
      sum_category_price += item.price if category_id == item.category_id
    end
    sum_category_price
  end
end

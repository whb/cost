class Expense < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  accepts_nested_attributes_for :items, :allow_destroy => true,
    :reject_if => lambda { |a| a[:category_id].blank? and a[:name].blank? and a[:amount].blank? and a[:unit].blank? and a[:unit_price].blank? }
  has_many :approvals
  belongs_to :organization
  attr_accessible :sn, :request_on, :staff, :organization_id, :items_attributes
  validates_presence_of :sn, :request_on, :staff, :organization, :items
  validates_uniqueness_of :sn

  STATUS_TYPES = {
    :edit => "Edit",
    :commit => "Commit",
    :manager_approval => "Manager Approval",
    :general_manager_approval => "General Manager Approval",
  }
  enum :status, STATUS_TYPES

  scope :activing, where(:status => [:edit, :commit, :manager_approval])

  def self.new_blank(current_user)
    expense = Expense.new
    expense.sn = generate_sn
    if current_user
      expense.organization = current_user.organization
      expense.staff = current_user.displayname
    else
      expense.organization = Organization.default
    end
    expense.request_on = Time.now.to_date
    3.times { expense.items.build }
    expense
  end

  def self.generate_sn
    "CST-%.6d" % (Expense.maximum('id') + 1)
  end

  def editable?
    self.status == :edit
  end

  def approvaling?
    self.status == :commit or self.status == :manager_approval
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
      sum_category_price += item.price if (category_id == item.category_id and item.price != nil)
    end
    sum_category_price
  end
end

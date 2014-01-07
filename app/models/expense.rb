class Expense < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  accepts_nested_attributes_for :items, :allow_destroy => true,
    :reject_if => lambda { |a| a[:category_id].blank? and a[:name].blank? and a[:amount].blank? and a[:unit].blank? and a[:unit_price].blank? and a[:price].blank?}
  has_many :approvals
  has_many :reimbursements
  belongs_to :organization
  attr_accessible :abstract, :sn, :request_on, :staff, :organization_id, :explain, :items_attributes
  validates_presence_of :abstract, :sn, :request_on, :staff, :organization, :items
  validates_uniqueness_of :sn

  STATUS_TYPES = {
    :edit => "Edit",
    :commit => "Commit",
    :manager_approval => "Manager Approval",
    :general_manager_approval => "General Manager Approval",
    :reimbursed => "Reimbursed",
    :invalid => "Invalid",
  }
  enum :status, STATUS_TYPES

  scope :activing, where(:status => [:edit, :commit, :manager_approval, :general_manager_approval])
  scope :approvalling, where(:status => [:commit, :manager_approval])
  scope :waiting_manager_approval, where(:status => :commit)
  scope :waiting_general_manager_approval, where(:status => :manager_approval)
  scope :waiting_reimburse, where(:status => :general_manager_approval)
  scope :reimbursed, where(:status => :reimbursed)

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
    max_id = Expense.maximum('id') ? Expense.maximum('id') : 0
    "SQ-%.6d" % (max_id + 1)
  end

  def editable?
    self.status == :edit
  end

  def approvaling?
    self.status == :commit or self.status == :manager_approval
  end

  def waiting_reimburse?
    self.status == :general_manager_approval
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

  def reimbursed
    self.status = :reimbursed
  end

  def category_price(budget_c)
    sum_category_price = 0
    items.each do |item|
      if (item.price != nil and budget_c.id == item.category_id)
        sum_category_price += item.price 
      else 
        next unless item.category
        sum_category_price += item.price if (item.price != nil and peroid.matched?(item.category, budget_c))
      end
    end
    sum_category_price
  end

  # ref_budget_list 
  def match_category?(budget_c)
    items.each do |item|
      next unless item.category
      return true if peroid.matched?(item.category, budget_c)
    end

    return false
  end

  def peroid
    year = request_on ? request_on.year : Date.today.year
    @period ||= Period.find_by_year(year)
  end
end

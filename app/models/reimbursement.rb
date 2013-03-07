class Reimbursement < ActiveRecord::Base
  include NumberToChineseAmountInWordsHelper

  has_many :details, :dependent => :destroy
  accepts_nested_attributes_for :details, :allow_destroy => true,
    :reject_if => lambda { |a| a[:category_id].blank? and a[:name].blank? and a[:amount].blank? and a[:unit].blank? and a[:unit_price].blank? and a[:price].blank?}
  belongs_to :organization
  belongs_to :expense
  attr_accessible :abstract, :amount, :expense_id, :invoice_no, :organization_id, :reimburse_on, :sn, :staff, :details_attributes
  validates_presence_of :sn, :reimburse_on, :staff, :organization, :abstract, :amount, :details
  validates_uniqueness_of :sn

  STATUS_TYPES = {
    :edit => "Edit",
    :commit => "Commit",
  }
  enum :status, STATUS_TYPES

  scope :activing, where(:status => :edit)
  scope :committed, where(:status => :commit)
  scope :interval, lambda { |interval|  where(:reimburse_on => interval) }
  scope :this_year, :conditions => "YEAR(reimburse_on) = #{Date.today.year}"
  scope :has_category, lambda { |category_id| joins(:details).where('details.category_id' => category_id) }

  def chinese_amount
    number_to_capital_zh(self.amount)
  end

  def build_part(current_user)
    self.sn = Reimbursement.generate_sn
    if current_user
      self.organization = current_user.organization
      self.staff = current_user.displayname
    else
      self.organization = Organization.default
    end
    self.reimburse_on = Time.now.to_date
  end

  def self.new_blank(current_user)
    reimbursement = Reimbursement.new
    reimbursement.build_part current_user

    1.times { reimbursement.details.build }
    reimbursement
  end

  def self.new_from_expense(expense, current_user)
    reimbursement = expense.reimbursements.build
    reimbursement.build_part current_user

    reimbursement.abstract = expense.abstract
    expense.items.each do |item|
      detail = reimbursement.details.build
      detail.copy(item)
    end
    reimbursement.amount = reimbursement.cal_amount
    reimbursement
  end

  def self.generate_sn
    max_id = Reimbursement.maximum('id') ? Reimbursement.maximum('id') : 0
    "VCH-%.6d" % (max_id + 1)
  end

  def category_price(category_id)
    sum_category_price = 0
    details.each do |detail|
      sum_category_price += detail.price if (category_id == detail.category_id and detail.price != nil)
    end
    sum_category_price
  end

  def has_category?(category_id)
    details.each do |detail|
      return true if category_id == detail.category_id
    end
    return false
  end

  def cal_amount
    amount = 0
    details.each do |detail|
      amount += detail.price
    end
    amount
  end

  def editable?
    self.status == :edit
  end

  def commit!
    transaction do
      expense = self.expense
      if expense
        expense.reimbursed
        expense.save!
      end
      self.status = :commit
      save!
    end
  end
end

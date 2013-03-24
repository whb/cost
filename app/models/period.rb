class Period < ActiveRecord::Base
  has_many :budgets, :dependent => :destroy
  accepts_nested_attributes_for :budgets, :allow_destroy => true
  attr_accessible :explain, :year, :budgets_attributes
  validates_presence_of :year

  def self.new_blank
    period = Period.new
    Category.order(:code).each do |c|
      b = period.budgets.build
      b.category = c
    end
    period
  end

  def append_new_categories
    exist_categories = self.budgets.map { |b| b.category }
    Category.order(:code).each do |c|
      unless exist_categories.include?(c) 
        b = self.budgets.build
        b.category = c
      end
    end
  end

  def order_budgets
    self.budgets.joins(:category).order('categories.code')
  end
end

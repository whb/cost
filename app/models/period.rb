class Period < ActiveRecord::Base
  has_many :budgets, :dependent => :destroy
  accepts_nested_attributes_for :budgets, :allow_destroy => true
  attr_accessible :explain, :year, :budgets_attributes

  def self.new_blank
    period = Period.new
    Category.all.each do |c|
      b = period.budgets.build
      b.category = c
    end
    period
  end
end

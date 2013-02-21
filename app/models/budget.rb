class Budget < ActiveRecord::Base
  belongs_to :period
  belongs_to :category
  attr_accessible :amount, :period_id, :category_id
  validates_presence_of :category_id

  def available
    amount == nil ? nil : amount - cost
  end

  def cost
    @cost ||= Detail.committed.year(period.year).sum(:price, :conditions => "category_id = #{self.category_id}")
  end
end

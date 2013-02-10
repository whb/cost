module PeriodsHelper
  def subtraction(available, current) 
    available == nil ? '' : available - current
  end

  def style(budget, expense)
    expense.items.each do |item|
      return "" if budget.category.id == item.category_id
    end
    return "display: none"
  end

end

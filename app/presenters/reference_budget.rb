class ReferenceBudget
  def initialize(budget, bill)
    @budget = budget
    @bill = bill
  end

  def id
    "ref_budget_" + @budget.category.id.to_s
  end

  def name
    @budget.category.name
  end

  def style()
    @bill.items.each do |item|
      return "" if @budget.category.id == item.category_id
    end
    return "display: none"
  end


  def available
    @budget.available
  end

  def current
    @bill.category_price(@budget.category.id)
  end

  def balance
    available == nil ? '' : available - current
  end
end
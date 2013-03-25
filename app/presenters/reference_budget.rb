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
    return @bill.match_category?(@budget.category) ? "" : "display: none"
  end


  def available
    @budget.available
  end

  def current
    @bill.category_price(@budget.category)
  end

  def balance
    available == nil ? nil : available - current
  end
end
class RefBudgetList
  include Enumerable

  def initialize(bill)
    @bill = bill
    @ref_budgets = []
    @bill.peroid.budgets.each do |bu|
      @ref_budgets << ReferenceBudget.new(bu, @bill) if bu.amount
    end
  end

  def each
    @ref_budgets.each { |i| yield i }
  end

  def category_matched_budget_category
    @bill.peroid.category_matched_budget_category
  end
end

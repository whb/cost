class RefBudgetList
  include Enumerable

  def initialize(bill, budgets)
    @bill = bill
    @ref_budgets = []
    budgets.each do |bu|
      @ref_budgets << ReferenceBudget.new(bu, @bill)
    end
  end

  def each(&block)
    @ref_budgets.each do |rb|
      block.call(rb)
    end
  end
end

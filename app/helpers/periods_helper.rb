module PeriodsHelper
  def subtraction(available, current) 
    available == nil ? '' : available - current
  end
end

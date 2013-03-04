class CostReportController < ApplicationController
  skip_authorization_check

  def organization_months
    @organization_amount_hash = {}
    @category = Category.find(params[:category_id]) if (params[:category_id])

    1.upto(12).each do | month |
      organization_sum = sum_organization_by_group(params[:category_id], month)
      Organization.all.each do | o |
        get_initialized_hash(@organization_amount_hash, o)[month] =
          organization_sum[o.id] ? organization_sum[o.id] : 0.00
      end
    end
  end

  def sum_organization_by_group(category_id, month)
    if (category_id)
      Detail.joins(:reimbursement).
        group('reimbursements.organization_id').
        where({'reimbursements.reimburse_on' => begin_to_end_of(month),
               :category_id => category_id}).
        sum(:price)
    else
      Reimbursement.group(:organization_id).
        where({:reimburse_on => begin_to_end_of(month)}).
        sum(:amount)
    end
  end



  def category_months
    @category_amount_hash = {}

    Category.all.each do | c |
      @category_amount_hash[c] = []

      1.upto(12).each do | month |
        sum_amount = Detail.joins(:reimbursement).
          where({'reimbursements.reimburse_on' => begin_to_end_of(month),
                 :category_id => c.id}).
          sum(:price)

        @category_amount_hash[c][month] = sum_amount
      end
    end
  end

  private
  def begin_to_end_of(month)
    this_year = Date.today.year
    begin_date = Date.new(this_year, month, 1)
    if (month == 12)
      end_date = Date.new(this_year + 1, 1, 1)
    else
      end_date = Date.new(this_year, month+1, 1)
    end
    return begin_date...end_date
  end

  def get_initialized_hash(hash, o)
    hash[o] ||= []
  end
end

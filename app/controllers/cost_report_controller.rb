class CostReportController < ApplicationController
  skip_authorization_check

  def organization_months
    @organization_amount_hash = {}
    @category = Category.find(params[:category_id]) if (params[:category_id])

    1.upto(12).each do | month |
      organization_sum = sum_organization_by_group(params[:category_id], month)
      Organization.all.each do | o |
        get_initialized_hash(@organization_amount_hash, o)[month] =
          organization_sum[o.id] ? organization_sum[o.id] : ""
      end
    end
  end

  def category_months
    @category_amount_hash = {}
    @organization = Organization.find(params[:organization_id]) if (params[:organization_id])

    1.upto(12).each do | month |
      category_sum = sum_category_by_group(params[:organization_id], month)
      Category.all.each do | c |
        get_initialized_hash(@category_amount_hash, c)[month] =
          category_sum[c.id] ? category_sum[c.id] : ""
      end
    end
  end

  private

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

  def sum_category_by_group(organization_id, month)
    if (organization_id)
      Detail.joins(:reimbursement).group(:category_id).
        where({ 'reimbursements.reimburse_on' => begin_to_end_of(month),
                'reimbursements.organization_id' => organization_id }).
        sum(:price)
    else
      Detail.joins(:reimbursement).group(:category_id).
        where({ 'reimbursements.reimburse_on' => begin_to_end_of(month) }).
        sum(:price)
    end
  end

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

class CostReportController < ApplicationController
  layout 'report'
  skip_authorization_check

  def organizations_cost
    @organizations = Organization.department
    @categories = Category.all
    @organizations_cost_hash = Detail.committed.this_year.joins(:reimbursement).group([:category_id, :organization_id]).sum(:price)
  end

  def detail_list
    if (params[:month] == '*')
      @month = params[:month]
      @details = Detail.committed.this_year
    else
      @month = params[:month].to_i
      @details = Detail.committed.interval(begin_to_end_of(@month))
    end

    if (params[:category_id] != '*')
      @category = Category.find(params[:category_id])
      @details = @details.belongs_to_category(@category.id)
    end

    if (params[:organization_id] != '*')
      @organization = Organization.find(params[:organization_id])
      @details = @details.belongs_to_organization(@organization.id)
    end

    @details
  end

  def organization_cost
    @organization = Organization.find(params[:organization_id]) unless params[:organization_id].blank?
    @category_amount_hash = {}
    1.upto(12).each do | month |
      category_sum = Detail.committed.interval(begin_to_end_of(month))
      category_sum = category_sum.belongs_to_organization(@organization.id) if @organization
      category_sum = category_sum.group(:category_id).sum(:price)

      Category.all.each do | c |
        get_initialized_hash(@category_amount_hash, c)[month] =
          category_sum[c.id] ? category_sum[c.id] : ""
      end
    end
    @selected_organization_id = @organization.id if @organization
  end

  def category_cost
    @category = Category.find(params[:category_id]) unless params[:category_id].blank?
    @organization_amount_hash = {}
    1.upto(12).each do | month |
      if (@category)
        organization_sum = Detail.committed.interval(begin_to_end_of(month)).belongs_to_category(@category.id).
          joins(:reimbursement).group(:organization_id).sum(:price)
      else
        organization_sum = Reimbursement.committed.interval(begin_to_end_of(month)).
          group(:organization_id).sum(:amount)
      end

      Organization.department.each do | o |
        get_initialized_hash(@organization_amount_hash, o)[month] =
          organization_sum[o.id] ? organization_sum[o.id] : ""
      end
    end
    @selected_category_id = @category.id if @category
  end

  def reimbursement_list
    if (params[:month] == '*')
      @month = params[:month]
      @reimbursements = Reimbursement.committed.this_year
    else
      @month = params[:month].to_i
      @reimbursements = Reimbursement.committed.interval(begin_to_end_of(@month))
    end

    if (params[:category_id] != '*')
      @category = Category.find(params[:category_id])
      @reimbursements = @reimbursements.has_category(@category.id)
    end

    if (params[:organization_id] != '*')
      @organization = Organization.find(params[:organization_id])
      @reimbursements = @reimbursements.find_all_by_organization_id(@organization.id)
    end
  end

  def get_initialized_hash(hash, o)
    hash[o] ||= []
  end





  # def organization_months
  #   @organization_amount_hash = {}
  #   @category = Category.find(params[:category_id]) if (params[:category_id])

  #   1.upto(12).each do | month |
  #     organization_sum = sum_organization_by_group(params[:category_id], month)
  #     Organization.all.each do | o |
  #       get_initialized_hash(@organization_amount_hash, o)[month] =
  #         organization_sum[o.id] ? organization_sum[o.id] : ""
  #     end
  #   end
  # end

  # def category_months
  #   @category_amount_hash = {}
  #   @organization = Organization.find(params[:organization_id]) if (params[:organization_id])

  #   1.upto(12).each do | month |
  #     category_sum = sum_category_by_group(params[:organization_id], month)
  #     Category.all.each do | c |
  #       get_initialized_hash(@category_amount_hash, c)[month] =
  #         category_sum[c.id] ? category_sum[c.id] : ""
  #     end
  #   end
  # end

  # private

  # def sum_organization_by_group(category_id, month)
  #   if (category_id)
  #     Detail.committed.interval(begin_to_end_of(month)).belongs_to_category(category_id).
  #       joins(:reimbursement).group(:organization_id).sum(:price)
  #   else
  #     Reimbursement.committed.interval(begin_to_end_of(month)).
  #       group(:organization_id).sum(:amount)
  #   end
  # end

  # def sum_category_by_group(organization_id, month)
  #   if (organization_id)
  #     Detail.committed.interval(begin_to_end_of(month)).belongs_to_organization(organization_id).
  #       group(:category_id).sum(:price)
  #   else
  #     Detail.committed.interval(begin_to_end_of(month)).
  #       group(:category_id).sum(:price)
  #   end
  # end

end

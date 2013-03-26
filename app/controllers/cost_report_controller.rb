class CostReportController < ApplicationController
  def organizations_cost
    authorize! :report, :cost
    @organizations = Organization.department
    @categories = Category.all
    @organizations_cost_hash = Detail.committed.this_year.joins(:reimbursement).
      group([:category_id, :organization_id]).sum(:price)

    @organizations.each do |o|
      @categories.each do |c|
        if c.branch_node?
          @organizations_cost_hash[[c.id, o.id]] = sum_child_leaf(c, o)
        end
      end
    end

    @summary = []
    @categories.each do |c|
      @organizations.each do |o|
        if @organizations_cost_hash[[c.id, o.id]]
          @summary[c.id] ||= 0
          @summary[c.id] += @organizations_cost_hash[[c.id, o.id]]
        end
      end
    end
  end

  def sum_child_leaf(category, organization)
    has_value = false
    sum = 0
    category.child_leaf_ids.each do |cid|
      if @organizations_cost_hash[[cid, organization.id]]
        sum += @organizations_cost_hash[[cid, organization.id]]
        has_value = true
      end
    end
    has_value ? sum : nil
  end

  def detail_list
    authorize! :report, :cost
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
    authorize! :report, :cost
    @organization = Organization.find(params[:organization_id]) unless params[:organization_id].blank?
    @category_amount_hash = {}
    1.upto(12).each do | month |
      category_sum = Detail.committed.interval(begin_to_end_of(month))
      category_sum = category_sum.belongs_to_organization(@organization.id) if @organization
      category_sum = category_sum.group(:category_id).sum(:price)

      Category.all.each do | c |
        get_initialized_hash(@category_amount_hash, c)[month] =
          category_sum[c.id] ? category_sum[c.id] : nil
      end

      Category.branch_nodes.each do | c |
        get_initialized_hash(@category_amount_hash, c)[month] =
          sum_child_leaf2(@category_amount_hash, c, month)
      end

    end
    @selected_organization_id = @organization.id if @organization

    @summary = sum_amount(Category.all, @category_amount_hash)
  end

  def sum_child_leaf2(amount_hash, category, month)
    has_value = false
    sum = 0
    category.child_leaves.each do |leaf|
      if amount_hash[leaf] && amount_hash[leaf][month]
        sum += amount_hash[leaf][month]
        has_value = true
      end
    end
    has_value ? sum : nil
  end

  def category_cost
    authorize! :report, :cost
    @category = Category.find(params[:category_id]) unless params[:category_id].blank?
    @organization_amount_hash = {}
    1.upto(12).each do | month |
      if (@category)
        query_id_or_ids = @category.branch_node? ? @category.child_leaf_ids : @category.id
        organization_sum = Detail.committed.interval(begin_to_end_of(month)).belongs_to_category(query_id_or_ids).
          joins(:reimbursement).group(:organization_id).sum(:price)
      else
        organization_sum = Reimbursement.committed.interval(begin_to_end_of(month)).
          group(:organization_id).sum(:amount)
      end

      Organization.department.each do | o |
        get_initialized_hash(@organization_amount_hash, o)[month] =
          organization_sum[o.id] ? organization_sum[o.id] : nil
      end
    end
    @selected_category_id = @category.id if @category

    @summary = sum_amount(Organization.department, @organization_amount_hash)
  end

  def reimbursement_list
    authorize! :report, :cost
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

  private

  def get_initialized_hash(hash, o)
    hash[o] ||= []
  end

  def sum_amount(collection, hash)
    summary = []
    collection.each do | o |
      hash[o].each do |amount|
        if amount
          summary[o.id] ||= 0
          summary[o.id] += amount
        end
      end
    end
    summary
  end
end

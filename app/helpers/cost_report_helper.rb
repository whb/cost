module CostReportHelper
  def smart_detail_list_path(category, organization, month)
    category_id = category ? category.id : '*'
    organization_id = organization ? organization.id : '*'
    detail_list_path(category_id, organization_id, month)
  end

  def link_details_query(amount, category, organization, month)
    return '' unless amount
    link_to humanized_money(amount), smart_detail_list_path(category, organization, '*')
  end

  def smart_reimbursement_list(category, organization, month)
    category_id = category ? category.id : '*'
    organization_id = organization ? organization.id : '*'
    reimbursement_list_path(category_id, organization_id, month)
  end

  def link_reimbursement_list(amount, category, organization, month)
    return '' unless amount
    link_to humanized_money(amount), smart_reimbursement_list(category, organization, month)
  end


  def detail_list_title(category, organization, month)
    category_name = category ? category.name : t('All Categories')
    organization_name = organization ? organization.name : t('All Organizations')
    month_name = (month == '*') ? t('Whole Year') : month.to_s + t('month')
    organization_name + '(' + category_name + ')' + ' : ' + month_name + t('Cost Details')
  end

  def reimbursement_list_title(category, organization, month)
    category_name = category ? category.name : t('All Categories')
    organization_name = organization ? organization.name : t('All Organizations')
    month_name = (month == '*') ? t('Whole Year') : month.to_s + t('month')
    organization_name + '(' + category_name + ')' + ' : ' + month_name + t('Reimbursement List')
  end

  def organization_cost_title(organization)
    organization_name = organization ? organization.name : t('All Organizations')
    organization_name + t('.title')
  end

  def category_cost_title(category)
    category_name = category ? category.name : t('All Categories')
    category_name + t('.title')
  end
end

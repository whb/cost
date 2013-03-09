module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    # link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')" )
  end

  def bootstrap_class_for flash_type
    case flash_type
    when :success
      "alert-success"
    when :error
      "alert-error"
    when :alert
      "alert-block"
    when :notice
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def agree_label_class agree
    agree ? "label-success" : "label-inverse"
  end

  def ref_budget_for(bill, budgets)
    presenter = RefBudgetList.new(bill, budgets)
    if block_given?
      yield presenter
    else
      presenter
    end
  end

  def expense_sn(expense)
    expense ? (link_to expense.sn, expense_path(expense)) : t('.none', :default => t("helpers.values.none"))
  end

  def expense_sn_modal(expense)
    expense ? (link_to expense.sn, "#expense_modal", :'data-toggle' => "modal" ) : t('.none', :default => t("helpers.values.none"))
  end

  def print_expense_sn(expense)
    expense ? expense.sn : t('.none', :default => t("helpers.values.none"))
  end

  def controller_is(name)
    @current_controller == name
  end

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

  def css_of_detail(detail, selected_category) 
    detail.category == selected_category ? 'info' : ''
  end

  def detail_list_title(category, organization, month)
    category_name = category ? category.name : t('All Categories')
    organization_name = organization ? organization.name : t('All Organizations')
    month_name = (month == '*') ? t('Whole Year') : month.to_s + t('month')
    organization_name + '(' + category_name + ')' + ' : ' + month_name + t('Cost Details')
  end

  def organization_cost_title(organization)
    organization_name = organization ? organization.name : t('All Organizations')
    organization_name + t('.title')
  end


  def reimbursement_list_title(category, organization, month)
    category_name = category ? category.name : t('All Categories')
    organization_name = organization ? organization.name : t('All Organizations')
    month_name = (month == '*') ? t('Whole Year') : month.to_s + t('month')
    organization_name + '(' + category_name + ')' + ' : ' + month_name + t('Reimbursement List')
  end

  def category_cost_title(category)
    category_name = category ? category.name : t('All Categories')
    category_name + t('.title')
  end

  def humanized_money(money)
    number_with_precision(money, :precision => (money.round == money) ? 0 : 2) if money
  end
end

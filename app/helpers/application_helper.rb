module ApplicationHelper
  def link_to_remove_fields(name, f, title)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", title: title)
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

  def css_of_detail(detail, selected_category)
    return '' unless selected_category
    selected_category.equals_or_has_child(detail.category) ? 'info' : ''
  end

  def humanized_money(money)
    number_with_precision(money, :precision => (money.round == money) ? 0 : 2) if money
  end

  def indent_code_name(category)
    case category.level
    when 1
      category.code_name
    when 2
      ("&nbsp;"*8).html_safe + category.code_name
    when 3
      ("&nbsp;"*16).html_safe + category.code_name
    else
      category.code_name
    end
  end
end

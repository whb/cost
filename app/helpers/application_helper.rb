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
    expense ? (link_to expense.sn, expense_path(expense)) : t(".none")
  end
end

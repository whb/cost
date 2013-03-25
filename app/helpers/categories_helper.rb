module CategoriesHelper
  def superior_category_name(category)
    category.superior == nil ? "" : category.superior.code_name
  end
end

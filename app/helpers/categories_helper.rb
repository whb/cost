module CategoriesHelper
  def major_category_name(category)
    category.major_category ? category.major_category.name : ""
  end

  def superior_category_name(category)
    category.superior == nil ? "" : category.superior.code_name
  end
end

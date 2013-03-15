module CategoriesHelper
  def major_category_name(category)
    category.major_category ? category.major_category.name : ""
  end
end

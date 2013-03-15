class AddMajorCategoryToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :major_category_id, :integer
  end
end

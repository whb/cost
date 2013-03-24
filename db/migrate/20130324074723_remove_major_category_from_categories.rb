class RemoveMajorCategoryFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :major_category_id
  end

  def down
    add_column :categories, :major_category_id, :integer
  end
end

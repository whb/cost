class DropMajorCategory < ActiveRecord::Migration
  def up
    drop_table :major_categories
  end

  def down
  end
end

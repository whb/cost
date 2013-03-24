class AddSuperiorToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :superior_id, :integer
  end
end

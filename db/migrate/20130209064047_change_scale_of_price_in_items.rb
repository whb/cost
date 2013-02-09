class ChangeScaleOfPriceInItems < ActiveRecord::Migration
  def up
    change_column :items, :unit_price, :decimal, :precision => 10, :scale => 2
    change_column :items, :price, :decimal, :precision => 10, :scale => 2
  end

  def down
  end
end

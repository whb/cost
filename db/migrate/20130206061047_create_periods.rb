class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :year
      t.string :explain

      t.timestamps
    end
  end
end

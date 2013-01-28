class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :no
      t.date :request_on
      t.string :staff

      t.timestamps
    end
  end
end

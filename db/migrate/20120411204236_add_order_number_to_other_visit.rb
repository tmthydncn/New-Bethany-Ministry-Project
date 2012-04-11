class AddOrderNumberToOtherVisit < ActiveRecord::Migration
  def change
    add_column :other_visits, :order_number, :integer
  end
end

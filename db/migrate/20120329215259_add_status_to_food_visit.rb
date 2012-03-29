class AddStatusToFoodVisit < ActiveRecord::Migration
  def change
    add_column :food_visits, :status, :string
  end
end

class RenameFoodVisitToBasketVisit < ActiveRecord::Migration
  def change
    rename_table :food_visits, :basket_visits
  end

end

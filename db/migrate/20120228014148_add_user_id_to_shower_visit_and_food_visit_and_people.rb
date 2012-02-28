class AddUserIdToShowerVisitAndFoodVisitAndPeople < ActiveRecord::Migration
  def self.up
    add_index :shower_visits, :user_id
    add_index :food_visits, :user_id
    add_index :people, :user_id
  end
  
  def self.down
    remove_index :shower_visits, :user_id
    remove_index :food_visits, :user_id
    remove_index :people, :user_id
  end
end

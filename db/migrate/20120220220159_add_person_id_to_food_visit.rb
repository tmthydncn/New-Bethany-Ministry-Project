class AddPersonIdToFoodVisit < ActiveRecord::Migration
  def self.up
    add_index :food_visits, :person_id
  end
  
  def self.down
    remove_index :food_visits, :person_id
  end
end

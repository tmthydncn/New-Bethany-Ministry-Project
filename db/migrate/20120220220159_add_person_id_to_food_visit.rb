class AddPersonIdToFoodVisit < ActiveRecord::Migration
  def self.up
    add_column :food_visits, :person_id, :integer
  end
  
  def self.down
    remove_column :food_visits, :person_id
  end
end

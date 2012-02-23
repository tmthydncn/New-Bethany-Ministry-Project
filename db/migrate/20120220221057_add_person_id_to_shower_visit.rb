class AddPersonIdToShowerVisit < ActiveRecord::Migration
  def self.up
    add_index :shower_visits, :person_id
  end
  
  def self.down
    remove_index :shower_visits, :person_id
  end
end

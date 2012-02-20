class AddPersonIdToShowerVisit < ActiveRecord::Migration
  def self.up
    add_column :shower_visits, :person_id, :integer
  end
  
  def self.down
    remove_column :shower_visits, :person_id
  end
end

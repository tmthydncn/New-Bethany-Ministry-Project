class AddIndexToPeopleSsn < ActiveRecord::Migration
  def change
    add_index :people, :ssn, unique: true
  end
end

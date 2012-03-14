class ChangeSsnToString < ActiveRecord::Migration
  def change
    change_column :people, :ssn, :string
  end     
end

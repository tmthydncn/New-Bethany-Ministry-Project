class AddStatusToOtherVisit < ActiveRecord::Migration
  def change
    add_column :other_visits, :status, :string
  end
end

class AddStatusToShowerVisits < ActiveRecord::Migration
  def change
    add_column :shower_visits, :status, :string
  end
end

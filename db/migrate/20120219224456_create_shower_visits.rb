class CreateShowerVisits < ActiveRecord::Migration
  def change
    create_table :shower_visits do |t|
      t.integer :order_number
      t.boolean :soap
      t.boolean :towel
      t.boolean :shampoo
      t.text :other

      t.timestamps
    end
  end
end

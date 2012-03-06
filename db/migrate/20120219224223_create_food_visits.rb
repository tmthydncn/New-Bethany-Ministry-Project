class CreateFoodVisits < ActiveRecord::Migration
  def change
    create_table :food_visits do |t|
      t.integer :order_number
      t.string :food_in
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_elderly
      t.text :special_needs
      
      t.integer :person_id
      t.integer :user_id

      t.timestamps
    end
  end
end

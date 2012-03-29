class NewFoodVisit < ActiveRecord::Migration
    def change
      create_table :food_visits do |t|
        t.integer :order_number

        t.integer :person_id
        t.integer :user_id

        t.timestamps
      end
    end
  end
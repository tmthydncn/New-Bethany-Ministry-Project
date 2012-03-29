class AddFieldToOtherVisit < ActiveRecord::Migration
  def change
      create_table :other_visits do |t|
        t.string :visit_type

        t.integer :person_id
        t.integer :user_id

        t.timestamps
      end
    end
  end

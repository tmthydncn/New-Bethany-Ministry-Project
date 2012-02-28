class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :gender
      t.decimal :ssn
      t.string :housing
      t.date :date_of_birth
      t.text :address
      t.string :ethnicity
      t.string :family_type
      t.string :education
      t.boolean :health_insurance
      t.boolean :drug_history
      t.boolean :criminal_background
      t.integer :people_in_house
      t.integer :employment_income
      t.integer :ssi
      t.integer :ssd
      t.integer :welfare
      t.text :other
      t.integer :child_support
      t.integer :food_stamps
      
      t.integer :user_id
      
      t.timestamps
    end
  end
end

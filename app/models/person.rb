class Person < ActiveRecord::Base
  #need validate here
  validates :first_name, :last_name, :ssn, :presence => true;
  has_many :shower_visits, dependent: :destroy
  has_many :food_visits, dependent: :destroy
  
  GENDER_TYPES = [ "Male", "Female" ]
  ETHNICITY_TYPES = [ "Hispanic", "African-American", "Caucasian", "Native American", "Other" ]
  INSURANCE_TYPES = [ "Yes - Private", "Yes - Medicaid (Access)", "Yes - Medicare", "No" ]
  HOUSING_TYPES = [ "Rent", "Rent-subsidized (housing/Section 8)", "Home owner", "Homeless", "Doubled-up (staying somewhere temporarily)" ]
  FAMILY_TYPES = ["Single (no children)", "2 adults (no children)", "Single parent (w/ children)", "2 parents (w/ children)"]
  
end

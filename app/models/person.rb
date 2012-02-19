class Person < ActiveRecord::Base
  #need validate here
  validates :first_name, :last_name, :presence => true;
  
  GENDER_TYPE = [ "Male", "Female" ]
  ETHNICITY_TYPE = [ "Hispanic", "African-American", "Caucasian", "Native American", "Other" ]
  INSURANCE_TYPE = [ "Yes - Private", "Yes - Medicaid (Access)", "Yes - Medicare", "No" ]
  HOUSING_TYPE = [ "Rent", "Rent-subsidized (housing/Section 8)", "Home owner", "Homeless", "Doubled-up (staying somewhere temporarily)" ]
  FAMILY_TYPE = ["Single (no children)", "2 adults (no children)", "Single parent (w/ children)", "2 parents (w/ children)"]
  
end

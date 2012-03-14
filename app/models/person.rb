# == Schema Information
#
# Table name: people
#
#  id                  :integer         not null, primary key
#  first_name          :string(255)
#  middle_name         :string(255)
#  last_name           :string(255)
#  gender              :string(255)
#  ssn                 :decimal(, )
#  housing             :string(255)
#  date_of_birth       :date
#  address             :text
#  ethnicity           :string(255)
#  family_type         :string(255)
#  education           :string(255)
#  health_insurance    :boolean
#  drug_history        :boolean
#  criminal_background :boolean
#  people_in_house     :integer
#  employment_income   :integer
#  ssi                 :integer
#  ssd                 :integer
#  welfare             :integer
#  other               :text
#  child_support       :integer
#  food_stamps         :integer
#  user_id             :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

class Person < ActiveRecord::Base
  #need validate here
  validates :first_name, :last_name, :ssn, :presence => true;
  with_options :allow_blank => true do |v|
    v.validates_length_of :ssn, :is => 9
    v.validates_numericality_of :ssn
    v.validates_uniqueness_of :ssn
  end
  validates_numericality_of :people_in_house, :greater_than => 0
  validates_numericality_of :welfare, :ssi, :ssd, :child_support, :employment_income, :food_stamps, :greater_than_or_equal_to => 0
  has_many :shower_visits, dependent: :destroy
  has_many :food_visits, dependent: :destroy
  belongs_to :user
  validates :user_id, presence: true
  
  attr_protected :user_id
  
  GENDER_TYPES = [ "Male", "Female" ]
  ETHNICITY_TYPES = [ "Hispanic", "African-American", "Caucasian", "Native American", "Other" ]
  INSURANCE_TYPES = [ "Yes - Private", "Yes - Medicaid (Access)", "Yes - Medicare", "No" ]
  HOUSING_TYPES = [ "Rent", "Rent-subsidized (housing/Section 8)", "Home owner", "Homeless", "Doubled-up (staying somewhere temporarily)" ]
  FAMILY_TYPES = ["Single (no children)", "2 adults (no children)", "Single parent (w/ children)", "2 parents (w/ children)"]
  
  def full_name
    name = self.first_name
    if not self.middle_name.empty?
      name += " " << self.middle_name
    end
    name += " " << self.last_name
  end
  
  def formatted_ssn
     "#{self.ssn}".sub(/(\d{3})(\d{2})(\d{4})/, "\\1-\\2-\\3")
  end
  

end

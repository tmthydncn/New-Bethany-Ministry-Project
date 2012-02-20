class FoodVisit < ActiveRecord::Base
  
  belongs_to :person
  validates :person, :presence => true
  validates_numericality_of :number_of_adults, :greater_than => 0

end

class FoodVisit < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  
  belongs_to :person
  belongs_to :user
  validates :person_id, :presence => true
  validates :user_id, presence: true
  
  attr_protected :user_id
  
  STATUS_TYPES = [ "Pending", "Completed", "Canceled"]
    
end
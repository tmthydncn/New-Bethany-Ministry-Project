
class OtherVisit < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  
  belongs_to :person
  belongs_to :user
  validates :person_id, :presence => true
  validates :user_id, presence: true
  
  attr_protected :user_id
    
  OTHER_VISIT_TYPES = [ "Type 1", "Type 2"]
  STATUS_TYPES = [ "Pending", "Completed", "Canceled"]
    
end
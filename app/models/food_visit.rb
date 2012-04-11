
class FoodVisit < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  
  belongs_to :person
  belongs_to :user
  validates :person_id, :presence => true
  validates :user_id, presence: true
    validates_presence_of :order_number
  
  attr_protected :user_id
  
  STATUS_TYPES = [ "Pending", "Completed", "Canceled"]
  
  def owners_full_name
    person.full_name
  end
  
  def updated_time_with_count
    time = self.created_at.strftime("%b %d, %Y at %H:%M")
    time << "\n#{time_ago_in_words(self.created_at) } ago"
  end
    
end
# == Schema Information
#
# Table name: food_visits
#
#  id                 :integer         not null, primary key
#  order_number       :integer
#  food_in            :boolean
#  number_of_adults   :integer
#  number_of_children :integer
#  number_of_elderly  :integer
#  special_needs      :text
#  person_id          :integer
#  user_id            :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

class FoodVisit < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  
  belongs_to :person
  belongs_to :user
  validates :person_id, :presence => true
  validates :user_id, presence: true
  validates_numericality_of :number_of_adults, :greater_than => 0
  validates_presence_of :order_number
  
  attr_accessible :user_id, :person_id, :order_number, :food_in, :number_of_adults, :number_of_children, :number_of_elderly, :special_needs, :status
  
  default_scope order: 'food_visits.created_at DESC'
  
  STATUS_TYPES = [ "Pending", "Completed", "Canceled"]
  NUMBER_OF_PEOPLE_TYPES = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
  
  def owners_full_name
    person.full_name
  end
  
  def updated_time_with_count
    time = self.updated_at.strftime("%Y/%m/%d at %H:%M:%S")
    time << "\n#{time_ago_in_words(self.updated_at) } ago"
  end

end

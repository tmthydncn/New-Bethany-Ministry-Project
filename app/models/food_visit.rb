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
  
  belongs_to :person
  belongs_to :user
  validates :person_id, :presence => true
  validates :user_id, presence: true
  validates_numericality_of :number_of_adults, :greater_than => 0
  
  default_scope order: 'food_visits.created_at DESC'
  
  def owners_full_name
    person.full_name
  end

end

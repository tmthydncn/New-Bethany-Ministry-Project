# == Schema Information
#
# Table name: shower_visits
#
#  id           :integer         not null, primary key
#  order_number :integer
#  soap         :boolean
#  towel        :boolean
#  shampoo      :boolean
#  other        :text
#  person_id    :integer
#  user_id      :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class ShowerVisit < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  
  belongs_to :person
  belongs_to :user
  validates :person, :presence => true
  validates_presence_of :order_number
  validates_numericality_of :order_number, :greater_than_or_equal_to => 0
  
  
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

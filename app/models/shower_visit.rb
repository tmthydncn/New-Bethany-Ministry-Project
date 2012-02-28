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
  
  belongs_to :person
  belongs_to :user
  validates :person, :presence => true
  
end

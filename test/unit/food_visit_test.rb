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

require 'test_helper'

class FoodVisitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

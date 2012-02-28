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

require 'test_helper'

class ShowerVisitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

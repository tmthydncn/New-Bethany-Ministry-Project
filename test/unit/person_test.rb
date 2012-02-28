# == Schema Information
#
# Table name: people
#
#  id                  :integer         not null, primary key
#  first_name          :string(255)
#  middle_name         :string(255)
#  last_name           :string(255)
#  gender              :string(255)
#  ssn                 :decimal(, )
#  housing             :string(255)
#  date_of_birth       :date
#  address             :text
#  ethnicity           :string(255)
#  family_type         :string(255)
#  education           :string(255)
#  health_insurance    :boolean
#  drug_history        :boolean
#  criminal_background :boolean
#  people_in_house     :integer
#  employment_income   :integer
#  ssi                 :integer
#  ssd                 :integer
#  welfare             :integer
#  other               :text
#  child_support       :integer
#  food_stamps         :integer
#  user_id             :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

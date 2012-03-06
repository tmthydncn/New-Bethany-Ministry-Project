# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
NBM::Application.initialize!

# Change the default date format
Date::DATE_FORMATS[:default] = "%B %d, %Y"
Time::DATE_FORMATS[:default] = "%B %d, %Y %H:%M"

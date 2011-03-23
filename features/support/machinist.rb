# Load the blueprints from over in test.
require "#{Rails.root}/features/support/blueprints"

# Reset the Machinist cache before each scenario.
Before { Machinist.reset_before_test }

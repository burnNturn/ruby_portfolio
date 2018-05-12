require_relative '../controller_macros' # or

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include ControllerMacros, :type => :controller
end
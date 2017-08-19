ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# note: require 'devise' after require 'rspec/rails'
require 'devise'

class ActiveSupport::TestCase
  include Devise::Test::ControllerHelpers
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

end

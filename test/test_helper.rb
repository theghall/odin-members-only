Rails.env = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def log_in_as(user)
    cookies[:user_id] = user.id
  end

  def log_out
    cookies.delete(:user_id)
  end
end

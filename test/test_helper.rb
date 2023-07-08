# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'minitest/autorun'
require 'minitest/mock'
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :faraday
  config.filter_sensitive_data('<ip2location_api_key>') do
    Rails.application.credentials.ip2location_api_key!
  end

  config.filter_sensitive_data('<nrel_api_key>') do
    Rails.application.credentials.nrel_api_key!
  end
end

module ActionDispatch
  class IntegrationTest
    include Capybara::DSL
    include Capybara::Minitest::Assertions

    Capybara.default_driver = :selenium_headless

    # Reset sessions and driver between tests
    teardown do
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
  end
end

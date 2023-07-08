require 'test_helper'

class LocalStationsTest < ActionDispatch::IntegrationTest
  test 'visiting the index' do
    VCR.use_cassette('local_stations_integration') do
      visit '/'
      assert_selector 'h1', text: 'Stations Map'
    end
  end
end

require 'test_helper'

class LocalStationsTest < ActionDispatch::IntegrationTest
  test 'visiting the index' do
    VCR.use_cassette('local_stations_integration') do
      visit '/'
      assert_selector 'h1', text: 'Stations Map'
      assert_selector 'div.mapboxgl-map'

      all('div.mapboxgl-marker-anchor-center').last.click
      assert page.has_selector?('div.mapboxgl-popup-content')
    end
  end
end

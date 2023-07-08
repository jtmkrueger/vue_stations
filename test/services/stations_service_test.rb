require 'test_helper'

class StationsServiceTest < ActiveSupport::TestCase
  test 'should return a list of stations' do
    VCR.use_cassette('stations_service') do
      ip = '2606:54c0:76a0:13f0::6a:51'
      geolocation = GeoipService.new(ip).get
      stations = StationsService.new(geolocation).all

      assert_not_nil stations
      assert_not JSON.parse(stations)['features'].empty?
    end
  end
end

require 'test_helper'

class GeoipServiceTest < ActiveSupport::TestCase
  test 'should return the correct geolocation' do
    VCR.use_cassette('geoip_service') do
      ip = '2606:54c0:76a0:13f0::6a:51'
      geolocation = GeoipService.new(ip).get

      assert_equal 41.823834, geolocation[:lat]
      assert_equal(-71.412697, geolocation[:lng])
    end
  end
end

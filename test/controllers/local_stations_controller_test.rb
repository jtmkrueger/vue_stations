# frozen_string_literal: true

require 'test_helper'

class LocalStationsControllerTest < ActionDispatch::IntegrationTest
  test 'index returns success' do
    VCR.use_cassette('local_stations_index') do
      get root_url
      assert_response :success
    end
  end

  test 'index sets a geolocation headers' do
    VCR.use_cassette('local_stations_index') do
      get root_url
      geo_header = Nokogiri::HTML
                   .parse(@response.body)
                   .at('meta[name="geolocation"]')['content']
      json_geo = JSON.parse(geo_header)

      assert_not_nil json_geo['lat']
      assert_not_nil json_geo['lng']
    end
  end
end

# frozen_string_literal: true

# Service for getting local stations as geojson
class StationsService
  def initialize(geolocation)
    @geolocation = geolocation
  end

  def all
    response = Faraday.get(
      "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.geojson?api_key=#{Rails.application.credentials.nrel_api_key!}&latitude=#{@geolocation[:lat]}&longitude=#{@geolocation[:lng]}"
    )
    stations = response.body
  end
end

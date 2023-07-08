# frozen_string_literal: true

# Purpose: Gets the geolocation of an IP address
class GeoipService
  def initialize(ip)
    # localhost doesn't have an IP address
    ip = '2606:54c0:76a0:13f0::6a:51' if Rails.env.development? || Rails.env.test?
    @ip = ip
  end

  # Returns a JSON string with the latitude and longitude of the IP address
  # TODO: Handle errors
  def get
    response = Faraday.get(
      "https://api.ip2location.io/?key=#{Rails.application.credentials.ip2location_api_key!}&ip=#{@ip}"
    )
    json = JSON.parse(response.body)

    { lat: json['latitude'], lng: json['longitude'] }
  end
end

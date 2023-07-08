# frozen_string_literal: true

# Controller for the local stations page
class LocalStationsController < ApplicationController
  def index
    @geolocation = GeoipService.new(request.remote_ip).get
    @stations = StationsService.new(@geolocation).all
  end
end

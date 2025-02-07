require "google_maps_service"
require "singleton"

class TestAreaController < ApplicationController
  PLACE_TYPES = [
    "art_gallery",
    # "atm", SILLY
    # "bakery", NONE
    "bar",
    "beauty_salon",
    "book_store",
    "cafe",
    "city_hall",
    "clothing_store",
    "florist",
    "furniture_store",
    "hair_care",
    "home_goods_store",
    "jewelry_store",
    "library",
    "liquor_store",
    "lodging",
    "movie_theater",
    "museum",
    "night_club",
    "park",
    "parking",
    # "pet_store", NONE
    "restaurant",
    "shoe_store",
    "tourist_attraction"
  ]
  def index
    @places = PLACE_TYPES.each_with_object({}) do |type, result|
      result[type.to_sym] = Clients::GooglePlaces.instance.get_places_by_type(type)
    end
  end

  def show
    @place = Clients::GooglePlaces.instance.get_places_by_type(params[:type])
    Rails.logger.info(@place)
  end


  def cache_key(type)
    "google_api:places_nearby:type:#{type}"
  end
end

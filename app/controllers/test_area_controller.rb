require "google_maps_service"
require "singleton"

class GooglePlacesClient
  include Singleton

  delegate :places_nearby, to: :client

  def initialize
    @client = GoogleMapsService::Client.new(
      key: ENV["GOOGLE_API_KEY"],
    )
  end

  def client
    @client
  end
end

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
      result[type.to_sym] = fetch_places_by_type(type)
    end
  end

  def show
    @places = fetch_places_by_type(params[:type])
  end

  private
    def fetch_places_by_type(type)
      Rails.logger.info("Checking cache for type: #{type}")
      Rails.cache.fetch(cache_key(type), expires_in: 1.week) do
        results = []
        page_token = nil

        Rails.logger.info("Fetching places for type after cache miss: #{type}")
        loop do
          begin
            response = GooglePlacesClient.instance.places_nearby(
              location: {
                lat: 34.2808835,
                lng: -119.2937986
              },
              radius: 500,
              type: type,
              page_token: page_token
            )
            results += response[:results]
            page_token = response[:next_page_token]
            break if page_token.blank?
          rescue GoogleMapsService::Error::InvalidRequestError
            # This exception is thrown when Google's dumb fucking API
            # hasn't gotten its next page ready for us yet.
            # Docs: https://developers.google.com/maps/documentation/places/web-service/search-nearby#PlaceSearchPaging
            Rails.logger.info("Next page not ready for #{type}, sleeping for 2 seconds")
            sleep 2
          end
        end
        { results: results.sort_by { |r| r[:name] } }
      end
    end

  def cache_key(type)
    "google_api:places_nearby:type:#{type}"
  end
end

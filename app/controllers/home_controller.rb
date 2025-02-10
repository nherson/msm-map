class HomeController < ApplicationController
  def index
    @places = Places::Types::ALL.each_with_object({}) do |type, result|
      result[type.to_sym] = fetch_places_by_type(type)
    end
  end

  private
    def fetch_places_by_type(type)
      Rails.logger.info("Checking cache for type: #{type}")
      Rails.cache.fetch(cache_key(type), expires_in: 1.week) do
        Clients::GooglePlaces.instance.get_places_by_type(type)
      end
    end

    def cache_key(type)
      "google_api:places_nearby:type:#{type}"
    end
end

class HomeController < ApplicationController
  def index
    cache_keys = Map::Types::ALL.map { |type| cache_key(type) }
    @places_by_type = Rails.cache.fetch_multi(*cache_keys, expires_in: 1.week) do |key|
      type = cache_key_to_type(key)
      Rails.logger.info("Cache miss for type: #{type}")
      Clients::GooglePlaces.instance.get_places_by_type(type)
    end
    @places_by_type.transform_keys! { |key| cache_key_to_type(key) }
    @places_by_type.transform_values! do |place_data|
      places = place_data[:results].map do |business_data|
        Map::Place.new(business_data)
      end
      Map::Place.sanitize_list!(places)
      places
    end
  end

  private

    def cache_key(type)
      "google_api:places_nearby:type:#{type}"
    end

    def cache_key_to_type(key)
      key.split(":").last
    end
end

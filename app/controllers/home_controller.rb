class HomeController < ApplicationController
  def index
    cache_keys = Places::Types::ALL.map { |type| cache_key(type) }
    @businesses_by_type = Rails.cache.fetch_multi(*cache_keys, expires_in: 1.week) do |key|
      type = cache_key_to_type(key)
      Rails.logger.info("Cache miss for type: #{type}")
      Clients::GooglePlaces.instance.get_places_by_type(type)
    end
    @businesses_by_type.transform_keys! { |key| cache_key_to_type(key) }
    @businesses_by_type.transform_values! do |place_data|
      businesses = place_data[:results].map do |business_data|
        Places::Business.new(business_data)
      end
      Places::Business.sanitize_list!(businesses)
      businesses
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

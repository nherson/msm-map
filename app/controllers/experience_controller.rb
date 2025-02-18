class ExperienceController < ApplicationController
  def index
    @options = PLACES_CONFIG["tags"]
  end

  def show
    # TODO: 404 on bad tag
    tag = params[:tag]
    cache_keys = Map::Types::ALL.map { |type| cache_key(type) }
    places_by_type = Rails.cache.fetch_multi(*cache_keys, expires_in: 1.week) do |key|
      type = cache_key_to_type(key)
      Rails.logger.info("Cache miss for type: #{type}")
      Clients::GooglePlaces.instance.get_places_by_type(type)
    end
    places_by_type.transform_values! do |place_data|
      places = place_data[:results].map do |business_data|
        Map::Place.new(business_data)
      end
      places
    end
    @places = places_by_type.values.flatten.uniq { |place| place.google_place_id }

    Map::Place.sanitize_list!(@places)

    @places = Map::Place.only_with_tag(@places, tag)
    Rails.logger.info(@places)
  end

  private

    def cache_key(type)
      "google_api:places_nearby:type:#{type}"
    end
end

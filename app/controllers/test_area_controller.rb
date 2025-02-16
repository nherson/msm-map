# A place to play around on localhost development, to quickly try things out
class TestAreaController < ApplicationController
  def index
    # @places = PLACE_TYPES.each_with_object({}) do |type, result|
    #   result[type.to_sym] = Clients::GooglePlaces.instance.get_places_by_type(type)
    # end
    render json: { disabled: true }
  end

  def show
    business_data = Rails.cache.fetch(cache_key(params[:type]), expires_in: 1.week) do |key|
      Clients::GooglePlaces.instance.get_places_by_type(type)
    end
    @businesses = business_data[:results].map { |place| Places::Business.new(place) }
    @businesses = Places::Business.sanitize_list!(@businesses)
  end

  private

    def cache_key(type)
      "google_api:places_nearby:type:#{type}"
    end
end

# A place to play around on localhost development, to quickly try things out
class TestAreaController < ApplicationController
  def index
    # @places = PLACE_TYPES.each_with_object({}) do |type, result|
    #   result[type.to_sym] = Clients::GooglePlaces.instance.get_places_by_type(type)
    # end
    render json: { disabled: true }
  end

  def show
    # @place = Clients::GooglePlaces.instance.get_places_by_type(params[:type])
    # Rails.logger.info(@place)
    render json: { disabled: true }
  end
end

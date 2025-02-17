module HomeHelper
  def map_link(place)
    coordinates = place.coordinates
    name = URI.encode_www_form_component(place.name)
    if browser.platform.ios?
      "maps://?q=#{name}&ll=#{coordinates.latitude},#{coordinates.longitude}"
    else
      "https://www.google.com/maps/place/?q=place_id:#{place.google_place_id}"
    end
  end
end

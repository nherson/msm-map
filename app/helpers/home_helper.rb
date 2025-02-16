module HomeHelper
  def map_link(business)
    coordinates = business.coordinates
    name = URI.encode_www_form_component(business.name)
    if browser.platform.ios?
      "maps://?q=#{name}&ll=#{coordinates.latitude},#{coordinates.longitude}"
    else
      "https://www.google.com/maps/place/?q=place_id:#{business.google_place_id}"
    end
  end
end

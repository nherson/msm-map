module HomeHelper
  def map_link(place)
    coordinates = place[:geometry][:location]
    name = URI.encode_www_form_component(place[:name])
    if browser.platform.ios?
      "maps://?q=#{name}&ll=#{coordinates[:lat]},#{coordinates[:lng]}"
    else
      "https://www.google.com/maps/place/?q=place_id:#{place[:place_id]}"
    end
  end
end

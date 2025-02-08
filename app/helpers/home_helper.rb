module HomeHelper
  def map_link(place)
    # "https://www.google.com/maps/place/?q=place_id:#{place[:place_id]}"
    base_url = "https://www.google.com/maps/search/?api=1"
    "#{base_url}&query_place_id=#{place[:place_id]}"
  end
end

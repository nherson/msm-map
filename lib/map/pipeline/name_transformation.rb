module Map
  module Pipeline
    class NameTransformation
      class << self
        def apply!(places)
          places.each do |place|
            place_config = Map::Place.config(place)
            next unless place_config

            place.name = place_config["name"] if place_config["name"]
          end
        end
      end
    end
  end
end

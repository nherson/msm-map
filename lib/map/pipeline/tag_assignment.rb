module Map
  module Pipeline
    class TagAssignment
      class << self
        def apply!(places)
          places.each do |place|
            place_config = Map::Place.config(place)
            next unless place_config

            place.tags.concat(place_config["tags"]) if place_config["tags"]
          end
        end
      end
    end
  end
end

# typed: true

module Map
  class Place
    class Tag
      ART = "art"
    end

    class << self
      def sanitize_list!(places)
        Pipeline::BogusFilter.apply!(places)
        Pipeline::NameTransformation.apply!(places)
        Pipeline::TagAssignment.apply!(places)
      end

      def config(place)
        PLACES_CONFIG["places"][place.google_place_id]
      end

      def only_with_tag(places, tag)
        places.filter { |place| place.tags.include?(tag) }
      end
    end

    attr_accessor :name, :tags
    attr_reader :google_place_id, :coordinates

    def initialize(google_place_data)
      @tags = []
      @google_place_id = google_place_data[:place_id]
      @name = google_place_data[:name]

      @coordinates = Coordinates.new(
        google_place_data[:geometry][:location][:lat],
        google_place_data[:geometry][:location][:lng]
      )
    end
  end
end

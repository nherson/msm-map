# typed: true

module Map
  class Coordinates
    attr_reader :latitude, :longitude

    def initialize(lat, lng)
      @latitude = lat
      @longitude = lng
    end
  end
end

# typed: true

module Places
  class Coordinates
    attr_reader :latitude, :longitude

    def initialize(lat, lng)
      @latitude = lat
      @longitude = lng
    end
  end
end

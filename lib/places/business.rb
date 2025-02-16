# typed: true

module Places
  class Business
    class << self
      def sanitize_list!(businesses)
        BogusFilter.apply!(businesses)
        NameTransformation.apply!(businesses)
      end
    end

    attr_accessor :name
    attr_reader :google_place_id, :coordinates

    def initialize(google_place_data)
      @google_place_id = google_place_data[:place_id]
      @name = google_place_data[:name]

      @coordinates = Coordinates.new(
        google_place_data[:geometry][:location][:lat],
        google_place_data[:geometry][:location][:lng]
      )
    end
  end
end

# typed: true

module Map
  module Pipeline
    class BogusFilter
      class << self
        def apply!(places)
          places.filter! { |b| !PLACES_CONFIG["bogus"][b.google_place_id] }
        end
      end
    end
  end
end

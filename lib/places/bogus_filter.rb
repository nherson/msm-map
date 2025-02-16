# typed: true

module Places
  class BogusFilter
    # Filter bogus businesses

    class << self
      # Add Google Place IDs to this list for businesses that are
      # garbage/fake/closed/etc.
      @@bogus_ids = Set.new([
        # Home Goods Store
        "ChIJq6rqUOWs6YARHcq4Vo4TTCU", # Global ENCASEMENT, Inc. (building restoration service)
        # Jewelry Stores
        "ChIJwXt0aDqt6YARawGwIgWT1lM", # TNJewelry1
        # Library
        "ChIJI2GXQqyt6YARooHQeM4M9p0", # Old library building (??)
        # Lodging
        "ChIJ_ztNZF6t6YARhei8iyUPO2M", # Mary mundo
        "ChIJUWWFofGs6YARtB1qOA_cxjo", # Ancient Aromatics Sea Spa (not a hotel)
        "ChIJba3geQCt6YARh7ieRFrvNvo" # Ventura main street
      ])

      def apply!(businesses)
        businesses.filter! { |b| !@@bogus_ids.include?(b.google_place_id) }
      end
    end
  end
end

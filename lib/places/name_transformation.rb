module Places
  class NameTransformation
    class << self
      @@transforms = {
        # This is a String:String mapping that takes a google_place_id as
        # a key and maps to a desired name. Use this when a business on Google
        # has some weird name that needs to be modified, e.g. the name itself
        # contains description of the business, extra info, etc.

        # Art Gallery
        "ChIJKenXYKhS6IARFUFcI0rGlUs": "Latitudes Gallery", # Latitudes Gallery - Ventura

        # Bar
        "ChIJ9_46V9ut6YARUys_TjOSN0o": "Finney's Crafthouse", # Finney's Crafthouse - Ventura

        # Clothing Store
        "ChIJZeCnPcqt6YARjVsfRjNQoKY": "House of Culture Ventura", # House of Culture Ventura, LLC
        "ChIJFbA0s--s6YARH77sud21AA4": "Rip Curl", # Rip Curl - Ventura

        # Furniture Store
        "ChIJ2e03iDGt6YARQoAxvrb73hI": "Eclecteak", # Eclecteak Home Luxury Teak Furniture & Rugs

        # Cafe
        "ChIJxdlFfbut6YARDluOou9TMcs": "Channel Islands Juice Co.", # Channel Islands Juice Co. | Healthy Restaurant With Organic Vegan Vegetarian Gluten Free, Coffee, Acai Bowls

        # Home Goods Store
        "ChIJD_Glnfqs6YAR8m4DP3zz744": "Maison De Michelle", # MAISON DE MICHELLE

        # Jewelry Store
        "ChIJZw0Zpvqs6YARz4qVaynBwGs": "Betty Belts", # Betty Belts | Ocean Room Gallery
        "ChIJJ25_pPGs6YARVxIpppRldzU": "Brooklyn Charm", # Brooklyn Charm - Ventura

        # Lodging
        "ChIJsT-X4Wet6YARJ7GV-DmFNA4": "Amanzi Hotel", # Amanzi Hotel, Ascend Hotel Collection
        "ChIJVZFrWO6s6YARr9JVYuVgUWY": "Crowne Plaza Ventura Beach", # Crowne Plaza Ventura Beach, an IHG Hotel
        "ChIJkwkaDO6s6YARRHH-6dR5kIU": "Motel 6" # Motel 6 Ventura, CA - downtown
      }

      def apply!(businesses)
        businesses.each do |business|
          business.name = @@transforms[business.google_place_id.to_sym] if @@transforms.include?(business.google_place_id.to_sym)
        end
      end
    end
  end
end

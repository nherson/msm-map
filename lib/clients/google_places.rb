module Clients
  class GooglePlaces
    include Singleton

    delegate :places_nearby, to: :client

    def initialize
      @client = GoogleMapsService::Client.new(
        key: ENV["GOOGLE_API_KEY"],
      )
    end

    def client
      @client
    end

    def get_places_by_type(type)
      results = []
      page_token = nil
      Rails.logger.info("Fetching places for type after cache miss: #{type}")
      loop do
        begin
          response = places_nearby(
            location: {
              lat: 34.2808835,
              lng: -119.2937986
            },
            radius: 500,
            type: type,
            page_token: page_token
          )
          results += response[:results]
          page_token = response[:next_page_token]
          break if page_token.blank?
        rescue GoogleMapsService::Error::InvalidRequestError
          # This exception is thrown when Google's dumb fucking API
          # hasn't gotten its next page ready for us yet.
          # Docs: https://developers.google.com/maps/documentation/places/web-service/search-nearby#PlaceSearchPaging
          Rails.logger.info("Next page not ready for #{type}, sleeping for 1 seconds")
          sleep 1
        end
      end
      Rails.logger.info("Found #{results.length} places for #{type}")
      { results: results.sort_by { |r| r[:name] } }
    end
  end
end

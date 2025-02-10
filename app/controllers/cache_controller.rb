class CacheController < ApplicationController
  protect_from_forgery with: :null_session

  http_basic_authenticate_with name: ENV["CACHE_REFRESH_USER"], password: ENV["CACHE_REFRESH_PASSWORD"], only: :refresh

  def refresh
    Rails.logger.info("Performing cache refresh")

    # Use a thread pool to fetch data faster (heavily IO bound operations)
    pool = Concurrent::FixedThreadPool.new(12)
    futures = Places::Types::ALL.map do |type|
      Concurrent::Future.execute(executor: pool) do
        { type: type, result: Clients::GooglePlaces.instance.get_places_by_type(type) }
      end
    end
    futures.each(&:wait)

    # Coelesce the responses into a hash that can be written to cache in one request
    cache_data =futures.map(&:value).each_with_object({}) do |response, object|
      object[cache_key(response[:type])] = response[:result]
    end
    Rails.cache.write_multi(cache_data, expires_in: 1.week)

    render json: { status: "ok" }
  end

  private

    def cache_key(type)
      "google_api:places_nearby:type:#{type}"
    end
end

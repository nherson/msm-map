class CacheController < ApplicationController
  # Require HTTP authentication only for the 'show' action
  # http_basic_authenticate_with name: "admin", password: "secret", only: :refresh
  http_basic_authenticate_with name: ENV["CACHE_REFRESH_USER"], password: ENV["CACHE_REFRESH_PASSWORD"], only: :refresh

  def refresh
    render json: { status: "ok" }
  end
end

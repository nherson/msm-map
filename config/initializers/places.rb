PLACES_CONFIG = YAML.load_file(Rails.root.join("config", "places.yml"))

if Rails.env.development?
  config_for_reloader = ActiveSupport::FileUpdateChecker.new([ "config/places.yml" ]) do
    Rails.logger.info("Reloading places.yml")
    PLACES_CONFIG = YAML.load_file(Rails.root.join("config", "places.yml"))
  end

  ActiveSupport::Reloader.to_prepare do
    config_for_reloader.execute_if_updated
  end
end

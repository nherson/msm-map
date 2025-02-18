class ExperienceController < ApplicationController
  def index
    @options = PLACES_CONFIG["tags"]
  end

  def show
  end
end

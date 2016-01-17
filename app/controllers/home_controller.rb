class HomeController < ApplicationController

  def index
  	sc_service = SoundCloudServices::Base.new()
  	@hot_tracks = sc_service.search("track")
  end

  def search_results
  end

end

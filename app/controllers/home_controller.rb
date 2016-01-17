class HomeController < ApplicationController

  def index
  	# sc_service = SoundCloudServices::Base.new()
  	# @hot_tracks = sc_service.search("track")
  	@hot_tracks = []
  end

  def search_results
  end

end

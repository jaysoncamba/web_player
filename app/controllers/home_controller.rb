class HomeController < ApplicationController

  before_filter :set_scobject

  def index 
    @hot_tracks = @sc_service.search("track")
  end

  def search_results
  end

  private

  def set_scobject
    @sc_service = SoundCloudServices::Base.new()
  end

end

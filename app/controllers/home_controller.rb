class HomeController < ApplicationController

  before_filter :set_scobject

  def index 
    @results = @sc_service.search
  end

  def search_results
    @results = @sc_service.search(params[:method].downcase, q: params[:term])
    render :index
  end

  private

  def set_scobject
    @sc_service = SoundCloudServices::Base.new()
  end

end

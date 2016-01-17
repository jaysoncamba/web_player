class HomeController < ApplicationController

  before_filter :set_scobject

  def index 
    @results = @sc_service.search
  end

  def search_results
    sc_field = params[:field].downcase == "term" ? {q: params[:term]} : {id: params[:term]}
    @results = @sc_service.search(params[:method].downcase, sc_field)
    render :index
  end

  private

  def set_scobject
    @sc_service = SoundCloudServices::Base.new()
  end

end

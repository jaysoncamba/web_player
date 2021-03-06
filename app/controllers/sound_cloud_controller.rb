class SoundCloudController < ApplicationController

  before_filter :set_scobject

  def user
    @user = @sc_service.search("user", id: params[:id]).first
  end

  def track
    @track = @sc_service.search("track", id: params[:id]).first
  end

  def playlist
    @playlist = @sc_service.search("playlist", id:  params[:id]).first
  end

  private

  def set_scobject
    @sc_service = SoundCloudServices::Base.new()
  end

end

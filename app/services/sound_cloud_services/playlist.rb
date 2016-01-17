module SoundCloudServices
  class Playlist < Base

    attr_accessor :id, :user_id, :artwork_url, :description, :permalink_url,
      :uri, :track_count, :playlist_count, :title, :user, :tracks, :created_at

    def initialize(sc_track = {})
      @sc_obj = sc_track
      set_attributes
      set_user
      set_tracks
    end

    def thumbnail_link
      @artwork_url.present? ? @artwork_url : (ActionController::Base.helpers.asset_path("soundcloud-icon.png"))
    end

    def to_html
      begin
        @embed_info ||= client.get('/oembed', :url => @permalink_url)
        @embed_info['html']
      rescue SoundCloud::ResponseError => e
        @embed_info = nil
      end
    end

    def set_user 
      @user = convert_user unless @user.is_a? SoundCloudServices::User
    end

    def set_tracks
      @tracks.map! do |track|
        convert_tracks(track)
      end
    end

    private
    
    def convert_user
      SoundCloudServices::User.new(user)
    end

    def convert_tracks(track)
      SoundCloudServices::Track.new(track)
    end

  end
end

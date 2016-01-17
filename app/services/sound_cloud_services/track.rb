module SoundCloudServices
  class Track < Base

    attr_accessor :id, :user_id, :artwork_url, :permalink_url, :created_at,
      :uri, :purchase_url, :title, :user, :description

    def initialize(sc_track = {})
      @sc_obj = sc_track
      set_attributes
      convert_user
    end

    def convert_user 
      @user = get_user unless @user.is_a? SoundCloudServices::User
    end

    def to_html
      begin
        @embed_info ||= client.get('/oembed', :url => @permalink_url)
        @embed_info['html']
      rescue SoundCloud::ResponseError => e
        @embed_info = nil
      end
    end

    def thumbnail_link
      @artwork_url.present? ? @artwork_url : (ActionController::Base.helpers.asset_path("soundcloud-icon.png"))
    end

    private
    
    def get_user
    	SoundCloudServices::User.new(user)
    end
  end
end

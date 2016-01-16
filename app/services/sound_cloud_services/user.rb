module Services
  module SoundCloudServices
    class User < Base

      attr_accessor :username, :permalink_url, :id, :avatar_url,
        :full_name, :track_count, :playlist_count

      def initialize(sc_user = {})
        @sc_obj = sc_user
        set_attributes
      end

      def tracks
      	@tracks ||= get_tracks
      end

       def playlists
      	@playlists ||= get_playlists
      end

      private
      
      def get_tracks
      	client.get("/users/#{id}/tracks").map{|track|
          SoundCloudServices::Track.new(track)
        }
      end

      def get_playlists
        client.get("/users/#{id}/playlists").map{|pl|
          SoundCloudServices::Playlist.new(pl)
        }
      end

    end
  end
end
module Services
  module SoundCloudServices
    class Base
  
      PAGE_SIZE = 10

      DEFAULT_OPTIONS = {
          "order" => 'created_at',
          "limit" => PAGE_SIZE
        }

      def self.attr_accessor(*vars)
        @attributes ||= []
        @attributes.concat vars
        super(*vars)
      end

      def self.attributes
        @attributes
      end

      def attributes
        self.class.attributes
      end

      def search (method='track', options ={}) 
        begin
          if options['id'].present?
            "Services::SoundCloudServices::#{method.capitalize.classify}".constantize.new(
              client.get("/#{method.pluralize}/#{options['id']}"))
          else
            results = client.get("/#{method.pluralize}", DEFAULT_OPTIONS.merge(options))
            results.map do |result|
              "Services::SoundCloudServices::#{method.capitalize.classify}".constantize.new(result)
            end
          end
        rescue Soundcloud::ResponseError => e
          {message: e.message, status_code: e.response.code}
        end
      end

      private

      def set_attributes
        attributes.each do |attr|
          send("#{attr}=", @sc_obj.try(attr))
        end
        remove_instance_variable(:@sc_obj)
      end

      def client
        @client ||= SoundCloud.new(client_id: ENV['SC_CLIENT_KEY'])  
      end

    end
  end
end
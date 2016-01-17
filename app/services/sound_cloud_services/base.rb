
module SoundCloudServices
  class Base

    PAGE_SIZE = 20

    DEFAULT_OPTIONS = {
        "order" => 'created_at',
        "limit" => PAGE_SIZE
      }

    METHODS = %W(track user playlist)

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
      return [] unless METHODS.include? method
      begin
        if options['id'].present?
          "SoundCloudServices::#{method.capitalize.classify}".constantize.new(
            client.get("/#{method.pluralize}/#{options['id']}"))
        else
          results = client.get("/#{method.pluralize}", DEFAULT_OPTIONS.merge(options))
          results.map do |result|
            "SoundCloudServices::#{method.capitalize.classify}".constantize.new(result)
          end
        end
      rescue Soundcloud::ResponseError => e
        nil
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

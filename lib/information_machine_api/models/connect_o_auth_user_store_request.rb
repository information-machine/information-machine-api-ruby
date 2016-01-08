

module InformationMachineApi
  class ConnectOAuthUserStoreRequest

    # TODO: Write general description for this method
    # @return [Numeric]
    attr_accessor :store_id

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :oauth_provider

    
    def method_missing (method_name)
      puts "there's no method called '#{method_name}'"
    end

    # Creates JSON of the curent object  
    def to_json
      hash = self.key_map()
      hash.to_json
    end

    # Defines the key map for json serialization  
    def key_map
      hash = {}
      hash['store_id'] = self.store_id
      hash['oauth_provider'] = self.oauth_provider
      hash
    end

  end
end
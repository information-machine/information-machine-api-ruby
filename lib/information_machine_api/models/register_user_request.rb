

module InformationMachineApi
  class RegisterUserRequest

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :email

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :zip

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :user_id

    
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
      hash['email'] = self.email
      hash['zip'] = self.zip
      hash['user_id'] = self.user_id
      hash
    end

  end
end
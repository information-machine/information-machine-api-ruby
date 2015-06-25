

module InformationMachineApi
  class AddCartRequest

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :cart_name

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :description

    
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
      hash['cart_name'] = self.cart_name
      hash['description'] = self.description
      hash
    end

  end
end
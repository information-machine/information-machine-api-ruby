

module InformationMachineApi
  class AddCartItemRequest

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :upc

    # TODO: Write general description for this method
    # @return [Numeric]
    attr_accessor :quantity

    
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
      hash['upc'] = self.upc
      hash['quantity'] = self.quantity
      hash
    end

  end
end
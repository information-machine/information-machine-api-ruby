

module InformationMachineApi
  class NameResolveRequest

    # TODO: Write general description for this method
    # @return [Array<String>]
    attr_accessor :name_store_list

    
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
      hash['name_store_list'] = self.name_store_list
      hash
    end

  end
end
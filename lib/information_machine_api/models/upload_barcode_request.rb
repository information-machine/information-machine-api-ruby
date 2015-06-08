

module InformationMachineApi
  class UploadBarcodeRequest

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :bar_code

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :bar_code_type

    
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
      hash['bar_code'] = self.bar_code
      hash['bar_code_type'] = self.bar_code_type
      hash
    end

  end
end
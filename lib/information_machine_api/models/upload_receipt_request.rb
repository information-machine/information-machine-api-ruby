

module InformationMachineApi
  class UploadReceiptRequest

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :receipt_id

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :image

    
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
      hash['receipt_id'] = self.receipt_id
      hash['image'] = self.image
      hash
    end

  end
end
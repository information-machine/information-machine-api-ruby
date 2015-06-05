

module InformationMachineApi
  class UploadReceiptRequest < JSONable

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :receipt_id

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :image

    
    def method_missing (method_name)
      puts "there's no method called '#{method_name}'"
    end

  end
end
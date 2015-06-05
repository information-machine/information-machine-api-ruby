

module InformationMachineApi
  class UploadBarcodeRequest < JSONable

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :bar_code

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :bar_code_type

    
    def method_missing (method_name)
      puts "there's no method called '#{method_name}'"
    end

  end
end
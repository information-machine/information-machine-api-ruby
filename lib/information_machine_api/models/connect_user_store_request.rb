

module InformationMachineApi
  class ConnectUserStoreRequest < JSONable

    # TODO: Write general description for this method
    # @return [Numeric]
    attr_accessor :store_id

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :username

    # TODO: Write general description for this method
    # @return [String]
    attr_accessor :password

    
    def method_missing (method_name)
      puts "there's no method called '#{method_name}'"
    end

  end
end
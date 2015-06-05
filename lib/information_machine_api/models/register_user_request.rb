

module InformationMachineApi
  class RegisterUserRequest < JSONable

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

  end
end
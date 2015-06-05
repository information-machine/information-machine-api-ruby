module InformationMachineApi
  class APITestException < StandardError

    # @param [String] the reason for raising an exception
    def initialize(reason)
        super(reason)
    end

  end
end


module InformationMachineApi
  class APIException < StandardError

    # value store
    attr_reader :response_code

    # The HTTP response code from the API request
    # @param [String] the reason for raising an exception
    # @param [Numeric] the HTTP response code from the API request
    def initialize(reason, response_code)
        super(reason)
        @response_code = response_code
    end

  end
end
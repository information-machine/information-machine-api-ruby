

module InformationMachineApi
  class UserManagementController

    # Initializer with authentication and configuration parameters
    def initialize(client_id, client_secret)
        @client_id = client_id;
        @client_secret = client_secret;
    end

    # Get all users associated with your account.
    # @param [Numeric] page Optional parameter: TODO: type description here
    # @param [Numeric] per_page Optional parameter: default:10, max:50
    # @return GetAllUsersWrapper response from the API call
    def user_management_get_all_users page: nil, per_page: nil
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "page" => page,
        "per_page" => per_page,
        "client_id" => @client_id,
        "client_secret" => @client_secret,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "IAMDATA V1",
        "accept" => "application/json"
      }

      # invoke the API call request to fetch the response
      response = Unirest.get query_url, headers:headers

      # Error handling using HTTP status codes
      if response.code == 400
        raise APIException.new "Bad request", 400
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Register a new user by specifying "email", "zip" and "user_id". The "user_id" is mandatory and it represents the identifier you will use to identify your user in the IM API infrastructure.Note: The following characters are restricted within "user_id" string ---&gt; { '/', '^', '[',  '\\', 'w', '.', ']', '+', '$', '/' }
    # @param [RegisterUserRequest] payload Required parameter: TODO: type description here
    # @return CreateUserWrapper response from the API call
    def user_management_create_user payload
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "client_id" => @client_id,
        "client_secret" => @client_secret,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "IAMDATA V1",
        "accept" => "application/json",
        "content-type" => "application/json; charset=utf-8"
      }

      # invoke the API call request to fetch the response
      response = Unirest.post query_url, headers:headers, parameters:payload

      # Error handling using HTTP status codes
      if response.code == 400
        raise APIException.new "Bad request", 400
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif response.code == 422
        raise APIException.new "Unprocessable entity", 422
      elsif response.code == 500
        raise APIException.new "Internal Server Error", 500
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Delete a user from the IM API infrastructure by specifying user's "id".
    # @param [String] id Required parameter: TODO: type description here
    # @return DeleteUserWrapper response from the API call
    def user_management_delete_user id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "id" => id,
        "client_id" => @client_id,
        "client_secret" => @client_secret,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "IAMDATA V1",
        "accept" => "application/json"
      }

      # invoke the API call request to fetch the response
      response = Unirest.delete query_url, headers:headers

      # Error handling using HTTP status codes
      if response.code == 404
        raise APIException.new "Not found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get user associated with your account specifying "id" of a user.
    # @param [String] id Required parameter: TODO: type description here
    # @return GetSingleUserWrapper response from the API call
    def user_management_get_single_user id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "id" => id,
      }

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "client_id" => @client_id,
        "client_secret" => @client_secret,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "IAMDATA V1",
        "accept" => "application/json"
      }

      # invoke the API call request to fetch the response
      response = Unirest.get query_url, headers:headers

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif response.code == 404
        raise APIException.new "Not Found", 404
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

  end
end
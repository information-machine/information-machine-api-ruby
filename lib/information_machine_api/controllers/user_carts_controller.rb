

module InformationMachineApi
  class UserCartsController

    # Initializer with authentication and configuration parameters
    def initialize(client_id, client_secret)
        @client_id = client_id;
        @client_secret = client_secret;
    end

    # Get all carts (including items in carts) associated with a specified user ID.
    # @param [String] user_id Required parameter: ID of a user
    # @return GetCartsWrapper response from the API call
    def user_carts_get_carts user_id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/users/{user_id}/carts"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
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
      elsif response.code == 422
        raise APIException.new "Unprocessable Entity", 422
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # IM API will generate Cart ID and return it in the response
    # @param [String] user_id Required parameter: ID of a user
    # @param [AddCartRequest] payload Required parameter: TODO: type description here
    # @return AddCartWrapper response from the API call
    def user_carts_create_cart user_id, payload
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/users/{user_id}/carts"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
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
        "accept" => "application/json",
        "content-type" => "application/json; charset=utf-8"
      }

      # invoke the API call request to fetch the response
      response = Unirest.post query_url, headers:headers, parameters:payload

      # Error handling using HTTP status codes
      if response.code == 400
        raise APIException.new "Bad Request", 400
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif response.code == 422
        raise APIException.new "Unprocessable Entity", 422
      elsif response.code == 500
        raise APIException.new "Internal Server Error", 500
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get detailed information on a single user cart by specifying User ID and Cart ID. Cart items are included in response.
    # @param [String] user_id Required parameter: ID of a user
    # @param [String] cart_id Required parameter: ID if a cart
    # @return GetCartWrapper response from the API call
    def user_carts_get_cart user_id, cart_id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/users/{user_id}/carts/{cart_id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
        "cart_id" => cart_id,
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
      elsif response.code == 422
        raise APIException.new "Unprocessable Entity", 422
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Add item/product to a cart, must specify product UPC and Cart ID.
    # @param [String] user_id Required parameter: ID of a user
    # @param [String] cart_id Required parameter: ID if a cart
    # @param [AddCartItemRequest] payload Required parameter: TODO: type description here
    # @return AddCartItemWrapper response from the API call
    def user_carts_add_cart_item user_id, cart_id, payload
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/users/{user_id}/carts/{cart_id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
        "cart_id" => cart_id,
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
        "accept" => "application/json",
        "content-type" => "application/json; charset=utf-8"
      }

      # invoke the API call request to fetch the response
      response = Unirest.post query_url, headers:headers, parameters:payload

      # Error handling using HTTP status codes
      if response.code == 400
        raise APIException.new "Bad Request", 400
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif response.code == 422
        raise APIException.new "Unprocessable Entity", 422
      elsif response.code == 500
        raise APIException.new "Internal Server Error", 500
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Use specified Cart ID to delete cart and all associated items in specified cart.
    # @param [String] user_id Required parameter: ID of a user
    # @param [String] cart_id Required parameter: ID if a cart
    # @return DeleteCartWrapper response from the API call
    def user_carts_delete_cart user_id, cart_id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/users/{user_id}/carts/{cart_id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
        "cart_id" => cart_id,
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
      response = Unirest.delete query_url, headers:headers

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif response.code == 404
        raise APIException.new "Not Found", 404
      elsif response.code == 422
        raise APIException.new "Unprocessable Entity", 422
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Remove item/product from a cart, must specify Cart and Cart Item ID.
    # @param [String] user_id Required parameter: ID of a user
    # @param [String] cart_id Required parameter: ID if a cart
    # @param [String] cart_item_id Required parameter: ID if a cart item
    # @return DeleteCartItemWrapper response from the API call
    def user_carts_remove_cart_item user_id, cart_id, cart_item_id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/users/{user_id}/carts/{cart_id}/items/{cart_item_id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
        "cart_id" => cart_id,
        "cart_item_id" => cart_item_id,
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
      response = Unirest.delete query_url, headers:headers

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif response.code == 404
        raise APIException.new "Not Found", 404
      elsif response.code == 422
        raise APIException.new "Unprocessable Entity", 422
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # TODO: type endpoint description here
    # @param [String] user_id Required parameter: ID of a user
    # @param [String] cart_id Required parameter: ID if a cart
    # @param [Numeric] store_id Required parameter: ID if a store (check "Lookup" section, "v1/stores" endpoint)
    # @return ExecuteCartWrapper response from the API call
    def user_carts_execute_cart user_id, cart_id, store_id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/users/{user_id}/carts/{cart_id}/stores/{store_id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
        "cart_id" => cart_id,
        "store_id" => store_id,
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
      elsif response.code == 422
        raise APIException.new "Unprocessable Entity", 422
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

  end
end
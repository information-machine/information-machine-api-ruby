

module InformationMachineApi
  class LookupController

    # Initializer with authentication and configuration parameters
    def initialize(client_id, client_secret)
        @client_id = client_id;
        @client_secret = client_secret;
    end

    # Get a list of all possible categories available for alternative product recommendations.
    # @return GetProductAlternativeTypesWrapper response from the API call
    def lookup_get_product_alternative_types
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/product_alternative_types"

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
      if response.code == 404
        raise APIException.new "Not Found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get a list of the units of measurement that could be associated with a product's nutrition facts.
    # @return GetUOMsWrapper response from the API call
    def lookup_get_uo_ms
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/units_of_measurement"

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
      if response.code == 404
        raise APIException.new "Not Found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get a list of all potential product categories.  Product categories follow a hierarchical structure that is defined through the "parent_id" field.
    # @return GetCategoriesWrapper response from the API call
    def lookup_get_categories
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/categories"

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
      if response.code == 404
        raise APIException.new "Not Found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get a list of all the nutrients that are available on a product's nutrition label.
    # @return GetNutrientsWrapper response from the API call
    def lookup_get_nutrients
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/nutrients"

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
      if response.code == 404
        raise APIException.new "Not Found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get a list of all stores in the IM API infrastructure. This list is constantly expanding. For stores that have "can_scrape" flag set to "1", you can use the IM infrastructure to retrieve purchase history. To do this, connect the store using the endpoints under the "Users" section below.
    # @return GetStoresWrapper response from the API call
    def lookup_get_stores
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/stores"

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
      if response.code == 404
        raise APIException.new "Not Found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get a list of all tags available through the IM infrastructure.
    # @return GetTagsWrapper response from the API call
    def lookup_get_tags
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/tags"

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
      if response.code == 404
        raise APIException.new "Not Found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

  end
end
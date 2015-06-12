

module InformationMachineApi
  class ProductsController

    # Initializer with authentication and configuration parameters
    def initialize(client_id, client_secret)
        @client_id = client_id;
        @client_secret = client_secret;
    end

    # You can query the IM product database by either product name or UPC/EAN/ISBN identifier. Note: If both parameters are specified, UPC/EAN/ISBN has higher priority.
    # @param [String] name Optional parameter: Product name (or part)
    # @param [String] product_identifier Optional parameter: UPC/EAN/ISBN
    # @param [Numeric] page Optional parameter: TODO: type description here
    # @param [Numeric] per_page Optional parameter: default:10, max:50
    # @param [String] request_data Optional parameter: Additional request data sent by IM API customer. Expected format:"Key1:Value1;Key2:Value2"
    # @param [Boolean] full_resp Optional parameter: default:false (set true for response with nutrients)
    # @return GetProductsWrapper response from the API call
    def products_search_products name: nil, product_identifier: nil, page: nil, per_page: nil, request_data: nil, full_resp: nil
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/products"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "name" => name,
        "product_identifier" => product_identifier,
        "page" => page,
        "per_page" => per_page,
        "request_data" => request_data,
        "full_resp" => full_resp,
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
        raise APIException.new "Not found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get details about a single product in the IM database by specifying a Information Machine Product ID.
    # @param [String] product_id Required parameter: TODO: type description here
    # @param [Boolean] full_resp Optional parameter: default:false (set true for response with nutrients)
    # @return GetProductWrapper response from the API call
    def products_get_product product_id, full_resp: nil
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/products/{product_id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "product_id" => product_id,
      }

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "full_resp" => full_resp,
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
        raise APIException.new "Not found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get all purchases a user has made for a product by specifying the associated product ID.
    # @param [String] product_id Required parameter: TODO: type description here
    # @param [Numeric] page Optional parameter: TODO: type description here
    # @param [Numeric] per_page Optional parameter: default:10, max:50
    # @return GetProductPurchasesWrapper response from the API call
    def products_get_product_purchases product_id, page: nil, per_page: nil
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/products/{product_id}/purchases"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "product_id" => product_id,
      }

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
      if response.code == 404
        raise APIException.new "Not found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get prices (from available stores) for specified product IDs. Note: It is possible to query 20 product IDs per each request. Please separate IDs with commas (e.g.: "325365, 89300").
    # @param [String] product_ids Required parameter: TODO: type description here
    # @return GetProductPricesWrapper response from the API call
    def products_get_product_prices product_ids
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/products_prices"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "product_ids" => product_ids,
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
        raise APIException.new "Not found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get product alternatives for a specified alternative type (e.g.: "type_id: 7" will display alternatives of the "general" type) for a list of products specified by product IDs. Note: See "Lookup" section, "product_alternative_type" for list of all possible alternative types. List of product ids must not contain more than 20 ids or else Bad Request will be returned.
    # @param [String] product_ids Required parameter: TODO: type description here
    # @param [String] type_id Optional parameter: TODO: type description here
    # @return GetProductsAlternativesWrapper response from the API call
    def products_get_products_alternatives product_ids, type_id: nil
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/products_alternatives"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "product_ids" => product_ids,
        "type_id" => type_id,
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
      elsif response.code == 404
        raise APIException.new "Not found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get full history of products purchased by a specified user at connected stores, must define "user_id".
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [Numeric] page Optional parameter: TODO: type description here
    # @param [Numeric] per_page Optional parameter: default:10, max:50
    # @param [Boolean] full_resp Optional parameter: default:false (set true for response with nutrients)
    # @param [Boolean] food_only Optional parameter: default:false (set true to list food products only)
    # @return GetUserProducts response from the API call
    def products_get_user_products user_id, page: nil, per_page: nil, full_resp: nil, food_only: nil
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/products"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
      }

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "page" => page,
        "per_page" => per_page,
        "full_resp" => full_resp,
        "food_only" => food_only,
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
        raise APIException.new "Not found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

  end
end
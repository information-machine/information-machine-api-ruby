

module InformationMachineApi
  class UserPurchasesController

    # Initializer with authentication and configuration parameters
    def initialize(client_id, client_secret)
        @client_id = client_id;
        @client_secret = client_secret;
    end

    # Get full history of purchases made by a specified user from connected stores, must specify “user_id".
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [Numeric] page Optional parameter: TODO: type description here
    # @param [Numeric] per_page Optional parameter: default:10, max:50
    # @param [Boolean] full_resp Optional parameter: default:false (set true for response with purchase item details)
    # @return GetAllUserPurchasesWrapper response from the API call
    def user_purchases_get_all_user_purchases user_id, page: nil, per_page: nil, full_resp: nil
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/purchases"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
      }

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "page" => page,
        "per_page" => per_page,
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
        raise APIException.new "Not Found", 404
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Get details about an identified purchase (specify “purchase_id”) made my a specific user (specify “user_id”).
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [String] purchase_id Required parameter: TODO: type description here
    # @param [Boolean] full_resp Optional parameter: default:false (set true for response with purchase item details)
    # @return GetSingleUserPurchaseWrapper response from the API call
    def user_purchases_get_single_user_purchase user_id, purchase_id, full_resp: nil
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/purchases/{purchase_id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
        "purchase_id" => purchase_id,
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
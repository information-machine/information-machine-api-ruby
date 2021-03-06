

module InformationMachineApi
  class UserPurchasesController

    # Initializer with authentication and configuration parameters
    def initialize(client_id, client_secret)
        @client_id = client_id;
        @client_secret = client_secret;
    end

    # Get history of purchases made by a specified user from connected stores, must specify "user_id".
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [Numeric] store_id Optional parameter: Check Lookup/Stores section for ID of all stores. E.g., Amazon = 4, Walmart = 3.
    # @param [Boolean] food_only Optional parameter: default:false [Filter out food purchase items.]
    # @param [Boolean] upc_only Optional parameter: default:false [Filter out purchase items with UPC.]
    # @param [Boolean] show_product_details Optional parameter: default:false [Show details of a purchased products (image, nutrients, ingredients, manufacturer, etc..)]
    # @param [Boolean] receipts_only Optional parameter: default:false [Filter out purchases transcribed from receipts.]
    # @param [String] upc_resolved_after Optional parameter: List only purchases having UPC resolved by IM after specified date. Expected format: "yyyy-MM-dd"
    # @return GetUserPurchaseHistoryWrapper response from the API call
    def user_purchases_get_purchase_history_unified user_id, store_id: nil, food_only: nil, upc_only: nil, show_product_details: nil, receipts_only: nil, upc_resolved_after: nil
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/purchases_product_based"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
      }

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "store_id" => store_id,
        "food_only" => food_only,
        "upc_only" => upc_only,
        "show_product_details" => show_product_details,
        "receipts_only" => receipts_only,
        "upc_resolved_after" => upc_resolved_after,
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
        raise APIException.new "Not Found", 404, response.raw_body
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Get history of purchases made by a specified user from connected stores, must specify "user_id".
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [Numeric] store_id Optional parameter: Check Lookup/Stores section for ID of all stores. E.g., Amazon = 4, Walmart = 3.
    # @param [Numeric] page Optional parameter: default:1
    # @param [Numeric] per_page Optional parameter: default:10, max:50
    # @param [String] purchase_date_from Optional parameter: Define multiple date ranges by specifying "from" range date components, separated by comma ",". Equal number of "from" and "to" parameters is mandatory. Expected format: "yyyy-MM-dd, yyyy-MM-dd"e.g., "2015-04-18, 2015-06-25"
    # @param [String] purchase_date_to Optional parameter: Define multiple date ranges by specifying "to" range date components, separated by comma ",". Equal number of "from" and "to" parameters is mandatory. Expected format: "yyyy-MM-dd, yyyy-MM-dd"e.g., "2015-04-28, 2015-07-05"
    # @param [String] purchase_date_before Optional parameter: Filter out purchases made before specified date. Expected format: yyyy-MM-dd[e.g., 2015-04-18]
    # @param [String] purchase_date_after Optional parameter: Filter out purchases made after specified date. Expected format: yyyy-MM-dd[e.g., 2015-04-18]
    # @param [String] purchase_total_from Optional parameter: Define multiple total purchase price ranges by specifying "from" range price components, separated by comma ",". Equal number of "from" and "to" parameters is mandatory. Expected format: "X.YZ, X.YZ"e.g., "5.5, 16.5"
    # @param [String] purchase_total_to Optional parameter: Define multiple total purchase price ranges by specifying "to" range price components, separated by comma ",". Equal number of "from" and "to" parameters is mandatory. Expected format: "X.YZ, X.YZ"e.g., "5.7, 20"
    # @param [Double] purchase_total_less Optional parameter: Filter out purchases with grand total price less than specified amount.
    # @param [Double] purchase_total_greater Optional parameter: Filter out purchases with grand total price greater than specified amount.
    # @param [Boolean] full_resp Optional parameter: default:false [Set true for response with purchase item details.]
    # @param [Boolean] food_only Optional parameter: default:false [Filter out food purchase items.]
    # @param [Boolean] upc_only Optional parameter: default:false [Filter out purchase items with UPC.]
    # @param [Boolean] receipts_only Optional parameter: default:false [Filter out purchases transcribed from receipts.]
    # @param [String] upc_resolved_after Optional parameter: List only purchases having UPC resolved by IM after specified date. Expected format: "yyyy-MM-dd"
    # @return GetAllUserPurchasesWrapper response from the API call
    def user_purchases_get_all_user_purchases user_id, store_id: nil, page: nil, per_page: nil, purchase_date_from: nil, purchase_date_to: nil, purchase_date_before: nil, purchase_date_after: nil, purchase_total_from: nil, purchase_total_to: nil, purchase_total_less: nil, purchase_total_greater: nil, full_resp: nil, food_only: nil, upc_only: nil, receipts_only: nil, upc_resolved_after: nil
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/purchases_invoice_based"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
      }

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "store_id" => store_id,
        "page" => page,
        "per_page" => per_page,
        "purchase_date_from" => purchase_date_from,
        "purchase_date_to" => purchase_date_to,
        "purchase_date_before" => purchase_date_before,
        "purchase_date_after" => purchase_date_after,
        "purchase_total_from" => purchase_total_from,
        "purchase_total_to" => purchase_total_to,
        "purchase_total_less" => purchase_total_less,
        "purchase_total_greater" => purchase_total_greater,
        "full_resp" => full_resp,
        "food_only" => food_only,
        "upc_only" => upc_only,
        "receipts_only" => receipts_only,
        "upc_resolved_after" => upc_resolved_after,
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
        raise APIException.new "Not Found", 404, response.raw_body
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # This endpoint is obsolete. Consider using "users/{user_id}/purchase_history/".   Get history of loyalty purchases made by a specified user from connected stores, must specify "user_id".
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [Numeric] store_id Optional parameter: Check Lookup/Stores section for ID of all stores. E.g., Amazon = 4, Walmart = 3.
    # @param [Numeric] page Optional parameter: default:1
    # @param [Numeric] per_page Optional parameter: default:10, max:50
    # @param [Boolean] food_only Optional parameter: default:false [Filter out food purchase items.]
    # @param [Boolean] upc_only Optional parameter: default:false [Filter out purchase items with UPC.]
    # @param [String] upc_resolved_after Optional parameter: List only purchases having UPC resolved by IM after specified date. Expected format: "yyyy-MM-dd".
    # @param [String] record_created_after Optional parameter: List only purchases collected, i.e., database inserted by bots, after specified date. Not to be confused with purchase date (not existing for many loyalty purchases). Expected format: "yyyy-MM-dd"
    # @return GetAllUserLoyaltyPurchasesWrapper response from the API call
    def user_purchases_get_all_user_loyalty_purchases user_id, store_id: nil, page: nil, per_page: nil, food_only: nil, upc_only: nil, upc_resolved_after: nil, record_created_after: nil
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/loyalty_purchases"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
      }

      # process optional query parameters
      query_builder = APIHelper.append_url_with_query_parameters query_builder, {
        "store_id" => store_id,
        "page" => page,
        "per_page" => per_page,
        "food_only" => food_only,
        "upc_only" => upc_only,
        "upc_resolved_after" => upc_resolved_after,
        "record_created_after" => record_created_after,
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
        raise APIException.new "Not Found", 404, response.raw_body
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Get details about an identified purchase (specify "purchase_id") made my a specific user (specify "user_id").
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [String] purchase_id Required parameter: TODO: type description here
    # @param [Boolean] full_resp Optional parameter: default:false (set true for response with purchase item details)
    # @return GetSingleUserPurchaseWrapper response from the API call
    def user_purchases_get_single_user_purchase user_id, purchase_id, full_resp: nil
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

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
        raise APIException.new "Not Found", 404, response.raw_body
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

  end
end
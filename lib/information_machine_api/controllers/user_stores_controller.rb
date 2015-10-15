

module InformationMachineApi
  class UserStoresController

    # Initializer with authentication and configuration parameters
    def initialize(client_id, client_secret)
        @client_id = client_id;
        @client_secret = client_secret;
    end

    # Get all store connections for a specified user, must identify user by "user_id". Note: Within response focus on the following  properties: "scrape_status" and "credentials_status". Possible values for "scrape_status": "Not defined""Pending" - (scraping request is in queue and waiting to be processed)"Scraping" - (scraping is in progress)"Done" - (scraping is finished)"Done With Warning" - (not all purchases were scraped)Possible values for "credentials_status":"Not defined""Verified" - (scraping bots are able to log in to store site)"Invalid" - (supplied user name or password are not valid)"Unknown" - (user name or password are not know)"Checking" - (credentials verification is in progress)
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [Numeric] page Optional parameter: TODO: type description here
    # @param [Numeric] per_page Optional parameter: TODO: type description here
    # @return GetAllStoresWrapper response from the API call
    def user_stores_get_all_stores user_id, page: nil, per_page: nil
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/stores"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
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
      if response.code == 401
        raise APIException.new "Unauthorized", 401, response.raw_body
      elsif response.code == 404
        raise APIException.new "Not Found", 404, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Connect a user's store by specifying the user ID ("user_id"), store ID ("store_id") and user's credentials for specified store ("username" and "password"). You can find store IDs in Lookup/Stores section above or in this <a href="http://api.iamdata.co/docs/storeids" target="blank">LINK</a>. Note: Within response you should focus on the following properties: "scrape_status" and "credentials_status". Possible values for "scrape_status": "Not defined""Pending" - (scraping request is in queue and waiting to be processed)"Scraping" - (scraping is in progress)"Done" - (scraping is finished)"Done With Warning" - (not all purchases were scraped)Possible values for "credentials_status":"Not defined""Verified" - (scraping bots are able to log in to store site)"Invalid" - (supplied user name or password are not valid)"Unknown" - (user name or password are not know)"Checking" - (credentials verification is in progress)
    # @param [ConnectUserStoreRequest] payload Required parameter: TODO: type description here
    # @param [String] user_id Required parameter: TODO: type description here
    # @return ConnectStoreWrapper response from the API call
    def user_stores_connect_store payload, user_id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/stores"

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
      response = Unirest.post query_url, headers:headers, parameters:payload.to_json

      # Error handling using HTTP status codes
      if response.code == 400
        raise APIException.new "Bad request", 400, response.raw_body
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401, response.raw_body
      elsif response.code == 404
        raise APIException.new "Not Found", 404, response.raw_body
      elsif response.code == 500
        raise APIException.new "Internal Server Error", 500, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Get single store connection by specifying user ("user_id") and store connection ID ("id" - generated upon successful store connection). Note: Within response focus on the following properties: "scrape_status" and "credentials_status". Possible values for "scrape_status": "Not defined""Pending" - (scraping request is in queue and waiting to be processed)"Scraping" - (scraping is in progress)"Done" - (scraping is finished)"Done With Warning" - (not all purchases were scraped)Possible values for "credentials_status":"Not defined""Verified" - (scraping bots are able to log in to store site)"Invalid" - (supplied user name or password are not valid)"Unknown" - (user name or password are not know)"Checking" - (credentials verification is in progress)
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [Numeric] id Required parameter: TODO: type description here
    # @return GetSingleStoresWrapper response from the API call
    def user_stores_get_single_store user_id, id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/stores/{id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
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
        raise APIException.new "Unauthorized", 401, response.raw_body
      elsif response.code == 404
        raise APIException.new "Not Found", 404, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Update username and/or password of existing store connection, for a specified user ID ("user_id") and user store ID ("user_store_id"  - generated on store connect).
    # @param [UpdateUserStoreRequest] payload Required parameter: TODO: type description here
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [Numeric] id Required parameter: TODO: type description here
    # @return UpdateStoreConnectionWrapper response from the API call
    def user_stores_update_store_connection payload, user_id, id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/stores/{id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
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
        "accept" => "application/json",
        "content-type" => "application/json; charset=utf-8"
      }

      # invoke the API call request to fetch the response
      response = Unirest.put query_url, headers:headers, parameters:payload.to_json

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "Unauthorized", 401, response.raw_body
      elsif response.code == 404
        raise APIException.new "Not Found", 404, response.raw_body
      elsif response.code == 500
        raise APIException.new "Internal Server Error", 500, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Delete store connection for a specified user ("user_id") and specified store ("user_store_id"  - generated on store connect).
    # @param [String] user_id Required parameter: TODO: type description here
    # @param [Numeric] id Required parameter: TODO: type description here
    # @return DeleteSingleStoreWrapper response from the API call
    def user_stores_delete_single_store user_id, id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/stores/{id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "user_id" => user_id,
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
      response = Unirest.delete query_url, headers:headers

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "Unauthorized", 401, response.raw_body
      elsif response.code == 500
        raise APIException.new "Internal Server Error", 500, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

  end
end


module InformationMachineApi
  class UserScansController

    # Initializer with authentication and configuration parameters
    def initialize(client_id, client_secret)
        @client_id = client_id;
        @client_secret = client_secret;
    end

    # Upload a new product by barcode and associate it to a specified user.  Note: Execution might take up to 15 seconds, depending on whether barcode exists in database or IM service must gather data around uploaded barcode.  POST payload example: { "bar_code" : "021130126026", "bar_code_type" : "UPC-A" }
    # @param [UploadBarcodeRequest] payload Required parameter: TODO: type description here
    # @param [String] user_id Required parameter: ID of user in your system
    # @return UploadBarcodeWrapper response from the API call
    def user_scans_upload_barcode payload, user_id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/barcode"

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
        raise APIException.new "Bad request", 400
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif response.code == 500
        raise APIException.new "Internal Server Error", 500
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

    # Upload a receipt with unique ID ("receipt_id") and associate it to a specified user using "user_id" parameter. Note: Uploaded receipt image should be Base 64 encoded. For testing purposes you can find our Base 64 encoded logo here: http://api.iamdata.co/images/base64/encoded_logo.txt
    # @param [UploadReceiptRequest] payload Required parameter: TODO: type description here
    # @param [String] user_id Required parameter: TODO: type description here
    # @return UploadReceiptWrapper response from the API call
    def user_scans_upload_receipt payload, user_id
      # the base uri for api requests
      query_builder = Configuration::BASE_URI.dup

      # prepare query string for API call
      query_builder << "/v1/users/{user_id}/receipt"

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
        raise APIException.new "Bad request", 400
      elsif response.code == 401
        raise APIException.new "Unauthorized", 401
      elsif response.code == 500
        raise APIException.new "Internal Server Error", 500
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code
      end

      response.body
    end

  end
end
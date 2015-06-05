

module InformationMachineApi 
  class APIHelper
    
    # Replaces template parameters in the given url
    # @param [String] The query string builder to replace the template parameters
    # @param [Array] The parameters to replace in the url    
    def self.append_url_with_template_parameters(query_builder, parameters)    
      # perform parameter validation
      raise ArgumentError, 'Given value for parameter \"query_builder\" is invalid.' unless query_builder.is_a? String

      # return if there are no parameters to replace
      if parameters.nil? then
        abort('no parameters to append')
      end

      # iterate and append parameters
      parameters.map do |key, value|
        replace_value = ''

        if value.nil? 
            replace_value = ''
        elsif value.is_a? Enumerable
            replace_value = value.join("/")
        else
            replace_value = value.to_s
        end

        # find the template parameter and replace it with its value
        query_builder = query_builder.gsub('{' + key.to_s + '}', replace_value)
      end

      query_builder
    end
    
    # Appends the given set of parameters to the given query string
    # @param [String] The query string builder to replace the template parameters
    # @param [Array] The parameters to append
    def self.append_url_with_query_parameters(query_builder, parameters)    
      # perform parameter validation
      raise ArgumentError, 'Given value for parameter \"query_builder\" is invalid.' unless query_builder.is_a? String

      # return if there are no parameters to replace
      if parameters.nil? then
        abort('no parameters to append')
      end

      # does the query string already has parameters
      has_params = query_builder.include? '?'
      separator = if has_params then '&' else '?' end

      # append query with separator and parameters
	  query = ""
      parameters.each{|k,v|
        if(v != nil)
            query+=k.to_s + "=" + CGI::escape(v.to_s)+"&"
        end
      }
      
      query.slice!(query.length-1, 1)
      query_builder << separator << query
    end
    
    # Validates and processes the given Url
    # @param [String] The given Url to process
    # @return [String] Pre-processed Url as string
    def self.clean_url(url)
      # perform parameter validation
      raise ArgumentError, 'Invalid Url.' unless url.is_a? String

      # ensure that the urls are absolute
      matches = url.match(/^(https?:\/\/[^\/]+)/)
      raise ArgumentError, 'Invalid Url format.' if matches.nil?
        
      # get the http protocol match
      protocol = matches[1]

      # remove redundant forward slashes
      query = url[protocol.length..-1].gsub(/\/\/+/, '/')

      # return process url
      return protocol + query;
    end

  end
end
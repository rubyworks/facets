# TODO: URI query methods need work and new consideration.

require 'uri'
require 'facets/uri/cgi_escape'
require 'facets/module/alias_module_function'

module URI

  module_function

  #
  #
  #
  KEY_VALUE_SEPARATOR = ";"  # "&"

  #
  # Given a hash with parameter/value pairs construct a
  # standard query string.
  #
  #   URI.hash_to_query(:a => 1, :b => 2)
  #   #=> "a=1;b=2"
  #
  def query(parameters)
    return '' unless parameters
    pairs = []
    parameters.each do |param, value|
      pairs << "#{param}=#{cgi_escape(value.to_s)}"
    end
    return pairs.join(KEY_VALUE_SEPARATOR)
  end

  alias_module_function :hash_to_query, :query
  alias_module_function :hash_to_query_string, :query

  #
  # Extend the basic query string parser provided by the cgi module.
  # converts single valued params (the most common case) to
  # objects instead of arrays
  #
  # Returns hash of parameters, contains arrays for multivalued parameters
  # (multiselect, checkboxes , etc).
  #
  # If no query string is provided (nil or "") returns an empty hash.
  #
  def query_hash(query_string)
    return {} unless query_string

    query_parameters = cgi_parse(query_string)

    query_parameters.each { |key, val|
      ## replace the array with an object
      query_parameters[key] = val[0] if 1 == val.length
    }

    ## set default value to nil! cgi sets this to []
    query_parameters.default = nil

    return query_parameters
  end

  alias_module_function :query_to_hash, :query_hash
  alias_module_function :query_string_to_hash, :query_hash

  #
  # This method returns the query string of a uri.
  #
  # @param [String] uri
  #   The uri string.
  #
  # @return [String] 
  #   The query string, or `nil` if no query string.
  #
  def query_get(uri)
    return nil unless uri
    # gmosx: INVESTIGATE ruby's URI seems to differently handle
    # abs and rel uris.
    if md = URI::REGEXP::ABS_URI.match(uri)
      return md[8]
    elsif md = URI::REGEXP::REL_URI.match(uri)
      return md[7]
    end
    return nil
  end

  alias_method :get_query_string, :query_get

  #
  # Removes the query string from a +uri+.
  #
  # Returns the chomped uri.
  #
  def query_chomp(uri)
    return nil unless uri
    query_string = self.get_query_string(uri)
    return uri.dup.chomp("?#{query_string}")
  end

  alias_module_function :chomp_query_string, :query_chomp

  #
  # Get a uri and a hash of parameters. Inject the hash values
  # as parameters in the query sting path. Returns the full uri.
  #
  # uri       - the uri to filter (String)
  # parameter - hash of parameters to update
  #
  # Returns the full updated query string.
  #
  # @todo Optimize this method.
  #
  def query_update(uri, parameters)
    query_string = self.query_get(uri)
    rest = uri.dup.gsub(/\?#{query_string}/, "")

    hash = self.query_string_to_hash(query_string)
    hash.update(parameters)
    query_string = self.hash_to_query_string(hash)

    unless query_string.strip.empty?
      return "#{rest}?#{query_string}"
    else
      return rest
    end
  end

  alias_module_function :update_query_string, :query_update

  #
  # Gets the request uri, injects extra parameters in the query string
  # and returns a new uri. The request object is not modified.
  # There is always a qs string so an extra test is skipped.
  #
  # TODO: find a better name?
  #
  def update_request_uri(request, parameters)
    hash = request.parameters.dup()
    hash.update(parameters)

    ## use this in hash_to_query
    query_string = hash.collect { |k, v|
      "#{k}=#{v}"
    }.join(";")

    ## return "#{request.translated_uri}?#{query_string}"
    return "#{request.path}?#{query_string}"
  end

end

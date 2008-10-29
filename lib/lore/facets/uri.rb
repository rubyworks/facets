# = URI Extensions
#
# Convenience extensions to URI module.
#
# == Authors
#
# * Thomas Sawyer (7rans)
#
# == Copyright
#
# Copyright (c) 2005 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'uri'
#require 'cgi'

require 'facets/blank'

module URI

  module_function

  # Decode the uri components.

  def decode(uri)
    # gmosx: hmm is this needed?
    # guard against invalid filenames for example pictures with
    # spaces uploaded by users
    escaped_uri = uri.gsub(/ /, "+")

    if md = URI::REGEXP::REL_URI.match(escaped_uri)

      path = "#{md[5]}#{md[6]}"
      type = File.extname(path)
      query_string = md[7]

#      real_path = "#{$root_dir}/#{path}"

      parameters = URI.query_to_hash(query_string)
      path.gsub!(/\+/, " ")

      return [path, type, parameters, query_string]

    end # match

    # this is usefull for uncovering bugs!
    raise ArgumentError.new("the parameter '#{uri}' is not a valid uri")
  end

  # Extend the basic query string parser provided by the cgi module.
  # converts single valued params (the most common case) to
  # objects instead of arrays
  #
  # Input:
  # the query string
  #
  # Output:
  # hash of parameters, contains arrays for multivalued parameters
  # (multiselect, checkboxes , etc)
  # If no query string is provided (nil or "") returns an empty hash.

  def query_to_hash(query_string)
    return {} unless query_string

    query_parameters = cgi_parse(query_string)

    query_parameters.each { |key, val|
      # replace the array with an object
      query_parameters[key] = val[0] if 1 == val.length
    }

    # set default value to nil! cgi sets this to []
    query_parameters.default = nil

    return query_parameters
  end

  alias_method :query_string_to_hash, :query_to_hash

  # Given a hash with parameter/value pairs construct a
  # standard query string.
  #
  #   URI.hash_to_query(:a => 1, :b => 2)
  #   => "a=1&b=2"

  def hash_to_query(parameters)
    return '' unless parameters
    pairs = []
    parameters.each do |param, value|
      pairs << "#{param}=#{cgi_escape(value.to_s)}"
    end
    #return pairs.join('&')
    return pairs.join(";")
  end

  alias_method :hash_to_query_string, :hash_to_query

  #
  # TODO: How does this compare to URI.escape?

  def cgi_escape(string)
    string.gsub(/([^ a-zA-Z0-9_.-]+)/n) do
      '%' + $1.unpack('H2' * $1.size).join('%').upcase
    end.tr(' ', '+')
  end

  #

  def cgi_unescape(string)
    string.tr('+', ' ').gsub(/((?:%[0-9a-fA-F]{2})+)/n) do
      [$1.delete('%')].pack('H*')
    end
  end

  #

  def cgi_parse(query)
    params = Hash.new([].freeze)

    query.split(/[&;]/n).each do |pairs|
      key, value = pairs.split('=',2).collect{|v| cgi_unescape(v) }
      if params.has_key?(key)
        params[key].push(value)
      else
        params[key] = [value]
      end
    end

    params
  end

  # This method returns the query string of a uri
  #
  # Input:
  # the uri
  #
  # Output:
  # the query string.
  # returns nil if no query string

  def get_query_string(uri)
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

  # Removes the query string from a uri
  #
  # Input:
  # the uri
  #
  # Output:
  # the chomped uri.

  def chomp_query_string(uri)
    return nil unless uri
    query_string = self.get_query_string(uri)
    return uri.dup.chomp("?#{query_string}")
  end

  # Get a uri and a hash of parameters. Inject the hash values
  # as parameters in the query sting path. Returns the full
  # uri.
  #
  # Input:
  # the uri to filter (String)
  # hash of parameters to update
  #
  # Output:
  # the full updated query string
  #
  # TODO: optimize

  def update_query_string(uri, parameters)
    query_string = self.get_query_string(uri)
    rest = uri.dup.gsub(/\?#{query_string}/, "")

    hash = self.query_string_to_hash(query_string)
    hash.update(parameters)
    query_string = self.hash_to_query_string(hash)

    unless query_string.blank?
      return "#{rest}?#{query_string}"
    else
      return rest
    end
  end

  # TODO: find a better name.
  # Gets the request uri, injects extra parameters in the query string
  # and returns a new uri. The request object is not modified.
  # There is always a qs string so an extra test is skipped.

  def update_request_uri(request, parameters)
    hash = request.parameters.dup()
    hash.update(parameters)

    # use this in hash_to_querystring.
    query_string = hash.collect { |k, v|
      "#{k}=#{v}"
    }.join(";")

    #return "#{request.translated_uri}?#{query_string}"
    return "#{request.path}?#{query_string}"
  end

  module Kernel
    #
    def uri(s, w=%r{[^a-zA-Z_0-9./-]})
      URI.escape(s, w)
    end

    #
    def unuri(s)
      URI.unescape(s)
    end
  end

  module Hash
    #
    def to_uri
      URI.hash_to_query(self)
    end
  end

end

class Object #:nodoc:
  include URI::Kernel
end

class Hash #:nodoc:
  include URI::Hash
end


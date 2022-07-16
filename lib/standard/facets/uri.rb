require 'uri'
require 'cgi'

require 'facets/uri/cgi_escape.rb'
require 'facets/uri/cgi_unescape.rb'
require 'facets/uri/cgi_parse.rb'
require 'facets/uri/decode.rb'
require 'facets/uri/parameters.rb'
require 'facets/uri/query.rb'

module URI

  module Kernel
    #
    def uri(s, w=%r{[^a-zA-Z_0-9./-]})
      CGI.escape(s, w)
    end

    #
    def unuri(s)
      CGI.unescape(s)
    end
  end

  module Hash
    #
    def to_uri
      URI.hash_to_query_string(self)
    end
  end

end

class Object #:nodoc:
  include URI::Kernel
end

class Hash #:nodoc:
  include URI::Hash
end


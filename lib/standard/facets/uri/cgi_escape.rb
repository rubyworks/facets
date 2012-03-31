require 'uri'

module URI

  module_function

  # TODO: How does `URI.cgi_escape` compare to `URI.escape`?

  #
  # CGI escape
  #
  def cgi_escape(string)
    string.gsub(/([^ a-zA-Z0-9_.-]+)/n) do
      '%' + $1.unpack('H2' * $1.size).join('%').upcase
    end.tr(' ', '+')
  end

  #
  #
  #
  def cgi_unescape(string)
    string.tr('+', ' ').gsub(/((?:%[0-9a-fA-F]{2})+)/n) do
      [$1.delete('%')].pack('H*')
    end
  end

  #
  #
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

end


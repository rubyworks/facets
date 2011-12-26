class Hash

  # Allows for taking a hash and turning it into CGI params
  # Since 1.8.x does not have ordered hashes the params might not
  # be ordered.
  #
  # @todo Hash#url_params may require some URL escaping.
  #
  # @author Matt Kirk

  def url_params
    map do |k,v|
      if v.respond_to?(:join)
        "#{k}=#{v.join(",")}"
      else
        "#{k}=#{v}"
      end
    end.join("&")
  end

end

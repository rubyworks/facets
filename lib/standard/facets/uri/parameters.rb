require 'uri'

module URI

  # Allows for taking a hash and turning it into URI/CGI params
  # Since 1.8.x does not have ordered hashes the params might not
  # be ordered.
  #
  # @todo URI.parameters needs URI escaping.
  #
  # @author Matt Kirk

  def self.parameters(hash)
    hash.map do |k,v|
      if v.respond_to?(:join)
        "#{k}=#{v.join(",")}"
      else
        "#{k}=#{v}"
      end
    end.join("&")
  end

  # We cannot send nested hash as a param in HTTP requests. For example,
  # when we would like to send something like this:
  #
  #     {:key => "value", :nested => {:nest => "value"}}
  #
  # It would be (or should be) mapped like this:
  #
  #     /url/?key=value&nested=%7B%3Anest%3D%3E%5C%22value%5C%22%7D 
  #
  # Doesn’t look to good ;) However there is a simple way to convert a nested
  # hash into a params acceptable form. We can convert it to a form, that can
  # be mapped into params like this:
  #
  #     /url/?key=value&nested[nest]=value 
  #
  # Here is method to convert any nested hash to a “one level” equivalent:
  #
  # @author Maciej Mensfeld

  def self.nested_parameters(value, key=nil, hash={})
    case value
    when Hash
      value.each do |k,v|
        akey = key.nil? ? :"#{k}" : :"#{key}[#{k}]"
        nested_parameters(v, akey, hash) 
      end
      out_hash
    when Array
      value.each do |v|
        nested_parameters(v, "#{key}[]", hash)
      end
      hash
    when nil then ''
    else
      hash[key] = value
      hash
    end
    parameters(hash)
  end
 
end

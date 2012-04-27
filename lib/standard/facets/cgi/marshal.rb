require 'cgi'

class CGI

  # Create an hidden input field through which an object can can be marshalled.
  # This makes it very easy to pass form data betwenn requests.
  def marshal_to_cgi(name, iobj)
    data = CGI.escape(Marshal.dump(iobj))
    return %Q{<input type="hidden" name="__#{name}__" value="#{data}"/>\n}
  end

  # Create an hidden input field through which an object can can be marshalled.
  # This makes it very easy to pass form data between requests.
  def marshal_from_cgi(name)
    if self.params.has_key?("__#{name}__")
      return Marshal.load(CGI.unescape(self["__#{name}__"][0]))
    end
  end

end

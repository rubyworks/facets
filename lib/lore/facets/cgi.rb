# Title:: CGI Extensions
# Authors:: Trans
# Copying:: (c)2005 Trans
# License:: Ruby Licens

require 'cgi'

# = CGI Extensions

class CGI

  # Create an hidden input field through which an object can can be marshalled.
  # This makes it very easy to pass from data betwenn requests.
  def marshal_to_cgi(name, iobj)
    data = CGI.escape(Marshal.dump(iobj))
    return %Q{<input type="hidden" name="__#{name}__" value="#{data}"/>\n}
  end

  # Create an hidden input field through which an object can can be marshalled.
  # This makes it very easy to pass from data between requests.
  def marshal_from_cgi(name)
    if self.params.has_key?("__#{name}__")
      return Marshal.load(CGI.unescape(self["__#{name}__"][0]))
    end
  end

  # RENAME!!!!

  # Are these two good enough to replace CGI.escape?

  # Return an html "safe" version of the string,
  # where every &, < and > are replaced with appropriate entities.
  def esc(str)
    str.gsub(/&/,'&amp;').gsub(/</,'&lt;').gsub(/>/,'&gt;')
  end

  # Calls #esc, and then further replaces carriage returns and quote characters with entities.
  def escformat(str)
    esc(str).gsub(/[\r\n]+/,'&#13;&#10;').gsub(%r|"|,'&quot;').gsub(%r|'|,'&#39;')
  end

  class << self
    alias :escape_html :escapeHTML
    alias :unescape_html :unescapeHTML
    alias :escape_element :escapeElement
    alias :unescape_element :unescapeElement
  end

end


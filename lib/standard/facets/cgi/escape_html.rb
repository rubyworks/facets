require 'cgi'

class CGI

  # Extends `#escape_html` to support escape modes. By default all strings
  # are escaped on `&`, `>` and `<`. Add the `:nonstandard` mode to omit
  # this conversion.
  #
  # If no mode is given then the `:default` mode is used.
  #
  # Available modes include:
  # * `:quote`     - escapes single and double quotes
  # * `:newlines`  - escapes newline characters (\r and \n)
  # * `:ampersand` - escapes the ampersand sign
  # * `:brackets`  - escapes less-than and greater-than signs
  # * `:default`   - escapes double quotes
  #
  # @example
  #   escape_html("<tag>")  #=> "&lt;tag&gt;"
  #   escape_html("Example\nString", :newlines)  #=> "Example&#13;&#10;String"
  #   escape_html("\"QUOTE\"", false)  #=> "\"QUOTE\""
  #
  def self.escape_html(string, *modes)
    modes << :defualt if modes.empty?

    unless modes.include?(:nonstandard)
      string = string.gsub(/&/, '&amp;').gsub(/>/, '&gt;').gsub(/</, '&lt;')
    end

    modes.each do |mode|
      string = \
        case mode
        when :quote, :quotes
          string.gsub(%r|"|,'&quot;').gsub(%r|'|,'&#39;')
        when :newlines, :newlines
          string.gsub(/[\r\n]+/,'&#13;&#10;')
        when :ampersand
          string.gsub(/&/, '&amp;')
        when :bracket, :brackets
          string.gsub(/>/, '&gt;').gsub(/</, '&lt;')
        when :default, true
          string.gsub(/\"/, '&quot;')
        when false
        else
          raise ArgumentError, "unrecognized HTML escape mode -- #{node}"
        end
    end
  end

  class << self
    # @deprecated
    alias :escapeHTML :escape_html
  end

  if RUBY_VERSION < '1.9'
    class << self
      alias :unescape_html :unescapeHTML
      alias :escape_element :escapeElement
      alias :unescape_element :unescapeElement
    end
  end

end

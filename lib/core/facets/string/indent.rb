class String

  # Indent right by `n` copies of `c`, or left by removing up to `n` copies
  # of `c` from the start of each line if `n` is negative.
  #
  #   "a\nb".indent(2)       #=> "  a\n  b"
  #   "    a".indent(-2)     #=> "  a"
  #   "a".indent(2, "-")     #=> "--a"
  #
  # Empty lines aren't indented, unless `empty_lines` is true.
  #
  #   "a\n\nb".indent(2)              #=> "  a\n\n  b"
  #   "a\n\nb".indent(2, ' ', true)   #=> "  a\n  \n  b"
  #
  # Without `c`, it indents with the string's own indentation character,
  # a tab or a space, or a space if the string has no indentation.
  #
  #   "\ta".indent(1)  #=> "\t\ta"
  #
  # This matches ActiveSupport's String#indent, so the two agree whichever
  # is loaded. A negative `n` is a Facets addition.
  #
  # n           - The number of copies of `c` to add or remove. [Integer]
  # c           - The indentation string. [String]
  # empty_lines - Whether to indent empty lines too. [Boolean]
  #
  # Returns a new string with the indention. [String]
  #
  # Credit: Gavin Sinclair
  # Credit: Trans
  # Credit: Tyler Rick

  def indent(n, c=nil, empty_lines=false)
    c ||= self[/^[ \t]/] || ' '
    if n >= 0
      gsub(empty_lines ? /^/ : /^(?!$)/, c * n)
    else
      gsub(/^(?:#{Regexp.escape(c)}){0,#{-n}}/, "")
    end
  end

  # Equivalent to String#indent, but modifies the receiver in place.
  #
  # Returns this string with the indention. [String]

  def indent!(n, c=nil, empty_lines=false)
    replace(indent(n, c, empty_lines))
  end

  # Remove excessive indentation. Useful for multi-line strings
  # embeded in already indented code.
  #
  # size - The number of spaces to indent. [Integer]
  #
  # Examples
  #
  #     text = <<-END.unindent
  #         ohaie
  #           wurld
  #     END
  #     text  #=> "ohaie\n  wurld\n"
  #
  # Returns a new unindented string. [String]
  #
  # Credit: Noah Gibbs
  # Credit: mynyml

  def unindent(size=nil)
    if size
      indent(-size)
    else
      # The indentation of the least indented line that isn't blank.
      prefix = scan(/^[ \t]*(?=\S)/).min_by(&:size)
      return dup if prefix.nil? || prefix.empty?
      gsub(/^#{Regexp.escape(prefix)}/, '')
    end
  end

  # Equivalent to String#unindent, but modifies the receiver in place.
  #
  # Returns this string unindented. [String]
  #
  # Credit: mynyml

  def unindent!
    replace(unindent)
  end
end

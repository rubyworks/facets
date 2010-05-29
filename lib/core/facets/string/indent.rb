class String

  # Indent left or right by n spaces.
  # (This used to be called #tab and aliased as #indent.)
  #
  # CREDIT: Gavin Sinclair, Trans, Tyler Rick

  def indent(n, c=' ')
    if n >= 0
      gsub(/^/, c * n)
    else
      gsub(/^#{Regexp.escape(c)}{0,#{-n}}/, "")
    end
  end

  # Equivalent to String#indent, but modifies the receiver in place.

  def indent!(n, c=' ')
    replace(indent(n,c))
  end

  # Remove excessive indentation. Useful for multi-line strings embeded in
  # already indented code.
  #
  #   puts <<-END.unindent
  #     ohaie
  #       wurld
  #   END
  #
  #   # outputs:
  #   ohaie
  #     wurld
  #
  #   # instead of:
  #     ohaie
  #       wurld
  #
  # CREDIT: Noah Gibbs, mynyml

  def unindent(size=nil)
    if size
      indent(-size)
    else
      char = ' '
      self.scan(/^[\ \t]*\S/) do |m|
        if size.nil? || m.size < size
          size = m.size
          char = m[0...-1]
        end
      end
      size -= 1
      indent(-size, char)
    end
  end

  # Equivalent to String#unindent, but modifies the receiver in place.
  #
  # CREDIT: mynyml

  def unindent!
    self.replace(self.unindent)
  end

end


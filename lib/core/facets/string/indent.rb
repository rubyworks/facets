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
  #   <<-END.unindent
  #       ohaie
  #         wurld
  #   END
  #
  # Outputs ...
  #
  #   ohaie
  #     wurld
  #
  # Instead of ...
  #
  #       ohaie
  #         wurld
  #
  # CREDIT: Noah Gibbs, mynyml

  def unindent(size=nil)
    if size
      indent(-size)
    else
      ws = self.scan(/^([\ \t]*)\S/).flatten
      prefix = common_prefix(*ws)
      indent(-1, prefix)
    end
  end

  def common_prefix(*strings)
    return nil if strings.empty?
    first = strings.shift
    return first if strings.empty?

    index = 0
    while index < first.size
      char = first[index...index+1]
      strings.each do |str|
        sub = str[index...index+1]
        return str[0...index] unless sub == char
      end
      index += 1
    end
    first
  end
  private :common_prefix

  # Equivalent to String#unindent, but modifies the receiver in place.
  #
  # CREDIT: mynyml

  def unindent!
    self.replace(self.unindent)
  end

end


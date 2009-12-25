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

  # Outdent just indents a negative number of spaces.
  #
  # CREDIT: Noah Gibbs

  def outdent(n)
    indent(-n)
  end

end


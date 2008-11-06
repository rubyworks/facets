class String

  # Indent left or right by n spaces.
  # (This used to be called #tab and aliased as #indent.)
  #
  # CREDIT: Gavin Sinclair, Trans

  def indent(n)
    if n >= 0
      gsub(/^/, ' ' * n)
    else
      gsub(/^ {0,#{-n}}/, "")
    end
  end

  # Outdent just indents a negative number of spaces.
  #
  # CREDIT: Noah Gibbs

  def outdent(n)
    indent(-n)
  end

end


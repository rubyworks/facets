class String

  # Returns a new string with all new lines removed from
  # adjacent lines of text.
  #
  #   s = "This is\na test.\n\nIt clumps\nlines of text."
  #   s.fold
  #
  # _produces_
  #
  #   "This is a test.\n\nIt clumps lines of text. "
  #
  # One arguable flaw with this, that might need a fix:
  # if the given string ends in a newline, it is replaced with
  # a single space.
  #
  #   CREDIT: Trans

  def fold(ignore_indented=false)
    ns = ''
    i = 0
    br = self.scan(/(\n\s*\n|\Z)/m) do |m|
      b = $~.begin(1)
      e = $~.end(1)
      nl = $&
      tx = slice(i...b)
      if ignore_indented and slice(i...b) =~ /^[ ]+/
        ns << tx
      else
        ns << tx.gsub(/[ ]*\n+/,' ')
      end
      ns << nl
      i = e
    end
    ns
  end

end


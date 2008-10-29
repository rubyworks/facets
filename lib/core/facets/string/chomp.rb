class String

  # Left chomp.
  #
  #   "help".lchomp("h")  #=> "elp"
  #   "help".lchomp("k")  #=> "help"
  #
  #   CREDIT: Trans

  def lchomp(match)
    if index(match) == 0
      self[match.size..-1]
    else
      self.dup
    end
  end

  # In-place left chomp.
  #
  #   "help".lchomp("h")  #=> "elp"
  #   "help".lchomp("k")  #=> "help"
  #
  #   CREDIT: Trans

  def lchomp!(match)
    if index(match) == 0
      self[0...match.size] = ''
      self
    end
  end

end


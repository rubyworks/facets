class String

  # Like #scan but returns MatchData ($~) rather
  # then matched string ($&).
  #
  #   CREDIT: Trans

  def mscan(re) #:yield:
    if block_given?
      scan(re) { yield($~) }
    else
      m = []
      scan(re) { m << $~ }
      m
    end
  end

end


class String

  # Cleave a string. Break a string in two parts at
  # the nearest whitespace.
  #
  #  CREDIT: Trans

  def cleave(threshold=nil, len=nil)
    l = (len || size / 2)
    t = threshold || size

    h1 = self[0...l]
    h2 = self[l..-1]

    i1 = h1.rindex(/\s/) || 0
    d1 = (i1 - l).abs

    d2 = h2.index(/\s/) || l
    i2 = d2 + l

    d1 = (i1-l).abs
    d2 = (i2-l).abs

    if [d1, d2].min > t
      i = t
    elsif d1 < d2
      i = i1
    else
      i = i2
    end

    #dup.insert(l, "\n").gsub(/^\s+|\s+$/, '')
    return self[0..i].to_s.strip, self[i+1..-1].to_s.strip
  end

end

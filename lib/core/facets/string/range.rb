class String

  # Like #index but returns a Range.
  #
  #   "This is a test!".range('test')  #=> (10..13)
  #
  # CREDIT: Trans

  def range(pattern, offset=0)
    unless Regexp === pattern
      pattern = Regexp.new(Regexp.escape(pattern.to_s))
    end
    string = self[offset..-1]
    if md = pattern.match(string)
      return (md.begin(0)+offset)..(md.end(0)+offset-1)
    end
    nil
  end

  # Like #index_all but returns an array of Ranges.
  #
  #   "abc123abc123".range_all('abc')  #=> [0..2, 6..8]
  #
  # TODO: Add offset ?
  #
  # CREDIT: Trans

  def range_all(pattern, reuse=false)
    r = []; i = 0
    while i < self.length
      rng = range(pattern, i)
      if rng
        r << rng
        i += reuse ? 1 : rng.end + 1
      else
        break
      end
    end
    r.uniq
  end

  # Returns an array of ranges mapping
  # the characters per line.
  #
  #   "this\nis\na\ntest".range_of_line
  #   #=> [0..4, 5..7, 8..9, 10..13]
  #
  # CREDIT: Trans

  def range_of_line
    offset=0; charmap = []
    each_line do |line|
      charmap << (offset..(offset + line.length - 1))
      offset += line.length
    end
    charmap
  end

end


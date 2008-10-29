class String

  # Like #index but returns a Range.
  #
  #   "This is a test!".range('test')  #=> 10..13
  #
  #   CREDIT: Trans

  def range(s, offset=0)
    if index(s, offset)
      return ($~.begin(0))..($~.end(0)-1)
    end
    nil
  end

  # Like #index_all but returns an array of Ranges.
  #
  #   "abc123abc123".range_all('abc')  #=> [0..2, 6..8]
  #
  #   TODO: Add offset, perhaps ?
  #
  #   CREDIT: Trans

  def range_all(s, reuse=false)
    r = []; i = 0
    while i < self.length
      rng = range(s, i)
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
  #   CREDIT: Trans

  def range_of_line
    offset=0; charmap = []
    self.each do |line|
      charmap << (offset..(offset + line.length - 1))
      offset += line.length
    end
    charmap
  end

  # Like index but returns an array of all index locations.
  # The reuse flag allows the trailing portion of a match to be
  # reused for subsquent matches.
  #
  #   "abcabcabc".index_all('a')  #=> [0,3,6]
  #
  #   "bbb".index_all('bb', false)  #=> [0]
  #   "bbb".index_all('bb', true)   #=> [0,1]
  #
  #   TODO: Culd probably be defined for Indexable in general too.

  def index_all(s, reuse=false)
    s = Regexp.new(Regexp.escape(s)) unless Regexp===s
    ia = []; i = 0
    while (i = index(s,i))
      ia << i
      i += (reuse ? 1 : $~[0].size)
    end
    ia
  end

end


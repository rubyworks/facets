class String

  # Like index but returns an array of all index locations.
  # The reuse flag allows the trailing portion of a match to be
  # reused for subsquent matches.
  #
  #   "abcabcabc".index_all('a')  #=> [0,3,6]
  #
  #   "bbb".index_all('bb', false)  #=> [0]
  #   "bbb".index_all('bb', true)   #=> [0,1]
  #
  # TODO: Culd probably be defined for Indexable in general too.

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

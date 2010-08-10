class Symbol

  # Symbol does not end in `!`, `=`, or `?`.
  #
  #   :a.plain?   #=> true
  #   :a?.plain?  #=> false
  #   :a!.plain?  #=> false
  #   :a=.plain?  #=> false
  #
  def plain?
    c = to_s[-1,1]
    !(c == '=' || c == '?' || c == '!')
  end

  # Symbol ends in `=`.
  #
  #   :a=.setter? #=> true
  #   :a.setter?  #=> false
  #
  def setter?
    to_s[-1,1] == '='
  end

  # Symbol ends in `?`.
  #
  #   :a?.query? #=> true
  #   :a.query?  #=> false
  #
  def query?
    to_s[-1,1] == '?'
  end

  # Symbol ends in `!`.
  #
  #   :a!.bang? #=> true
  #   :a.bang?  #=> false
  #
  def bang?
    to_s[-1,1] == '!'
  end

end


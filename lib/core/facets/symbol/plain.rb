class Symbol

  def plain?
    c = to_s[-1,1]
    !(c == '=' || c == '?')
  end

  def setter?
    to_s[-1,1] == '='
  end

  def query?
    to_s[-1,1] == '?'
  end

end


class Pathname

  #
  def split_root
    head, tail = *::File.split_root(to_s)
    [self.class.new(head), self.class.new(tail)]
  end

end

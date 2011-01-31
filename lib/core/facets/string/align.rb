class String

  # Alignment method dispatches to #align_right, #align_left
  # or #align_center, accorging to the first +direction+ parameter.
  #
  #   s = <<-EOS
  #   This is a test
  #     and
  #     so on
  #   EOS
  #
  #   s.align(:right, 14)
  #
  # _produces_ ...
  #
  #   This is a test
  #              and
  #            so on
  #
  # Returns a String aligned right, left or center.
  def align(direction, n, sep="\n", c=' ')
    case direction
    when :right
      align_right(n, sep="\n", c=' ')
    when :left
      align_left(n, sep="\n", c=' ')
    when :center
      align_center(n, sep="\n", c=' ')
    else
      raise ArgumentError
    end
  end

  # Align a string to the right.
  #
  # The default alignment separation is a new line ("\n").
  # This can be changed as can be the padding string which
  # defaults to a single space (' ').
  #
  #   s = <<-EOS
  #   This is a test
  #     and
  #     so on
  #   EOS
  #
  #   s.align_right(14)
  #
  # _produces_ ...
  #
  #   This is a test
  #              and
  #            so on
  #
  # CREDIT: Trans

  def align_right(n, sep="\n", c=' ')
    return rjust(n.to_i,c.to_s) if sep==nil
    q = split(sep.to_s).map do |line|
      line.rjust(n.to_i,c.to_s)
    end
    q.join(sep.to_s)
  end

  # Align a string to the left.
  #
  # The default alignment separation is a new line ("\n").
  # This can be changed as can be the padding string which
  # defaults to a single space (' ').
  #
  #   s = <<-EOS
  #   This is a test
  #     and
  #     so on
  #   EOS
  #
  #   s.align_left(20, "\n", '.')
  #
  # _produces_ ...
  #
  #   This is a test......
  #   and.................
  #   so on...............
  #
  # CREDIT: Trans

  def align_left(n, sep="\n", c=' ')
    return ljust(n.to_i,c.to_s) if sep==nil
    q = split(sep.to_s).map do |line|
      line.strip.ljust(n.to_i,c.to_s)
    end
    q.join(sep.to_s)
  end

  # Centers each line of a string.
  #
  # The default alignment separation is a new line ("\n").
  # This can be changed as can be the padding string which
  # defaults to a single space (' ').
  #
  #   s = <<-EOS
  #     This is a test
  #     and
  #     so on
  #   EOS
  #
  #   s.align_center(14)
  #
  # _produces_ ...
  #
  #   This is a test
  #        and
  #       so on
  #
  # CREDIT: Trans

  def align_center(n, sep="\n", c=' ')
    return center(n.to_i,c.to_s) if sep==nil
    q = split(sep.to_s).collect { |line|
      line.center(n.to_i,c.to_s)
    }
    q.join(sep.to_s)
  end

end


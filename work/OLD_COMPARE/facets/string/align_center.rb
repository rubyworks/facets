
class String

  # Align a string to the right.
  # The defualt alignment seperation is a new line ("/n")
  # This can be changes as can be the padding string which
  # defaults to a single space (' ').
  def align_right( n, sep="\n", c=' ' )
    return rjust(n.to_i,c.to_s) if sep==nil
    q = split(sep.to_s).collect { |line|
      line.rjust(n.to_i,c.to_s)
    }
    q.join(sep.to_s)
  end

  # Align a string to the left.
  # The defualt alignment seperation is a new line ("/n")
  # This can be changes as can be the padding string which
  # defaults to a single space (' ').
  def align_left( n, sep="\n", c=' ' )
    return ljust(n.to_i,c.to_s) if sep==nil
    q = split(sep.to_s).collect { |line|
      line.ljust(n.to_i,c.to_s)
    }
    q.join(sep.to_s)
  end

  # Centers each line of a string.
  #
  #   s = <<-EOS
  #   This is a test
  #   and
  #   so on
  #   EOS
  #   puts s.align_center(14)
  #
  # _produces_
  #
  #   This is a test
  #        and
  #       so on
  #
  # Align a string to the center.
  # The defualt alignment seperation is a new line ("/n")
  # This can be changed as can be the padding string which
  # defaults to a single space (' ').
  def align_center( n, sep="\n", c=' ' )
    return center(n.to_i,c.to_s) if sep==nil
    q = split(sep.to_s).collect { |line|
      line.center(n.to_i,c.to_s)
    }
    q.join(sep.to_s)
  end

  # Deprecated alias for #align_center.
  #alias_method :center_lines, :align_center

end


#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
=begin test

  require 'test/unit'

  class TCString < Test::Unit::TestCase

    def test_align_right
      assert_equal( "      xxx", "xxx".align_right(9) )
    end

    def test_align_left
      assert_equal( "xxx      ", "xxx".align_left(9) )
    end

    def test_align_center
      assert_equal( "   xxx   ", "xxx".align_center(9) )
    end

  end

=end


class String

  # Aligns each line n spaces.
  # (This used to be #taballto.)
  #
  def tab(n)
    gsub(/^ */, ' ' * n)
  end

  # Preserves relative tabbing.
  # The first non-empty line ends up with n spaces before nonspace.
  #
  def tabto(n)
    if self =~ /^( *)\S/
      indent(n - $1.length)
    else
      self
    end
  end

  # Indent left or right by n spaces.
  # (This used to be called #tab and aliased as #indent.)
  #
  def indent(n)
    if n >= 0
      gsub(/^/, ' ' * n)
    else
      gsub(/^ {0,#{-n}}/, "")
    end
  end

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

    def test_tab
      a = "xyz".tab(4)
      assert_equal( '    ', a[0..3] )
      # Need to expand on this
    end

    def test_tabto
      a = "xyz".tabto(4)
      assert_equal( '    ', a[0..3] )
      # Need to expand on this
    end

    def test_indent
      a = "xyz".indent(4)
      assert_equal( '    ', a[0..3] )
      # Need to expand on this
    end

  end

=end

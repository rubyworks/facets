
class String

  # Returns a new string with all new lines removed from
  # adjacent lines of text.
  #
  #   s = "This is\na test.\n\nIt clumps\nlines of text."
  #   s.fold
  #
  # _produces_
  #
  #   "This is a test.\n\nIt clumps lines of text. "
  #
  #--
  # One possible flaw with this that might could use a fix: 
  # if the given string ends in a newline, it is replaced with
  # a single space.
  #++
  def fold(ignore_indented=false)
    ns = ''
    i = 0
    br = self.scan(/(\n\s*\n|\Z)/m) do |m|
      b = $~.begin(1)
      e = $~.end(1)
      nl = $&
      tx = slice(i...b)
      if ignore_indented and slice(i...b) =~ /^[ ]+/
        ns << tx
      else
        ns << tx.gsub(/[ ]*\n+/,' ')
      end
      ns << nl
      i = e
    end
    ns
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

    def test_fold_1
      s = "This is\na test.\n\nIt clumps\nlines of text."
      o = "This is a test.\n\nIt clumps lines of text."
      assert_equal( o, s.fold )
    end

    def test_fold_2
      s = "This is\na test.\n\n  This is pre.\n  Leave alone.\n\nIt clumps\nlines of text."
      o = "This is a test.\n\n  This is pre.\n  Leave alone.\n\nIt clumps lines of text."
      assert_equal( o, s.fold(true) )
    end

  end

=end

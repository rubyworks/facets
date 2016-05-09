
class String

  # Filters out words from a string based on block test.
  #
  #   "a string".word_filter { |word| word =~ /^a/ }  #=> "string"
  #
  def word_filter( &blk )
    s = self.dup
    s.word_filter!( &blk )
  end

  # In place version of #word_filter.
  #
  #   "a string".word_filter { |word| ... }
  #
  def word_filter! #:yield:
    rest_of_string = self
    wordfind = /(\w+)/
    offset = 0
    while wmatch = wordfind.match(rest_of_string)
      word = wmatch[0]
      range = offset+wmatch.begin(0) ... offset+wmatch.end(0)
      rest_of_string = wmatch.post_match
      self[range] = yield( word ).to_s
      offset = self.length - rest_of_string.length
    end
    self
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

    def test_word_filter
      s = "this is a test"
      n = s.word_filter{ |w| "#{w}1" }
      assert_equal( 'this1 is1 a1 test1', n )
    end

    def test_word_filter!
      s = "this is a test"
      s.word_filter!{ |w| "#{w}1" }
      assert_equal( 'this1 is1 a1 test1', s )
    end

  end

=end


class String

  # Iterate through each word of a string.
  #
  #   "a string".each_word { |word, range| ... }
  #
  def each_word( &yld )
    rest_of_string = self
    wordfind = /([-'\w]+)/
    arity = yld.arity
    offset = 0
    while wmatch = wordfind.match(rest_of_string)
      word = wmatch[0]
      range = offset+wmatch.begin(0) ... offset+wmatch.end(0)
      rest_of_string = wmatch.post_match
      if arity == 1
        yld.call(word)
      else
        yld.call(word, range)
      end
      offset = self.length - rest_of_string.length
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

    def test_each_word
      a = []
      i = "this is a test"
      i.each_word{ |w| a << w }
      assert_equal( ['this', 'is', 'a', 'test'], a )
    end

  end

=end

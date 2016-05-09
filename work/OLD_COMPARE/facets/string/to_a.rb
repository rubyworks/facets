
class String

  # Essentially makes #to_a an alias for split,
  # with the excpetion that if no divider is given
  # then the array is split on charaters, and
  # NOT on the global input record divider ($/).
  #
  # WARNING There is a slight chance of
  # incompatability with other libraries which
  # depend on spliting with $/ (although doing 
  # so is a very bad idea!).
 
  def to_a(div=//,limit=0)
    split(div,limit)
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

    def test_to_a
      arr = 'abc'
      assert_equal( ['a','b','c'], arr.to_a )
    end

  end

=end


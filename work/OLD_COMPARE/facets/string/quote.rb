require 'facets/string/bracket'

class String

  # Return a new string embraced by given quotes.
  # If no quotes are specified, then assumes single quotes.
  #
  #   "quote me".quote     #=> "'quote me'"
  #   "quote me".quote(2)  #=> "\"quote me\""
  #
  def quote(type=:s)
    case type.to_s.downcase
    when 's', 'single'
      bracket("'")
    when 'd', 'double'
      bracket('"')
    when 'b', 'back'
      bracket('`')
    else
      bracket("'")
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

    def setup
      @a =  "hi"
    end

    def test_001
      assert_raises( ArgumentError ) { @a.quote(1,2) }
    end

    def test_002
      assert_equal( %{'hi'}, @a.quote )
    end

    def test_003
      assert_equal( %{"hi"}, @a.quote(:d) )
      assert_equal( %{"hi"}, @a.quote(:double) )
    end

    def test_004
      assert_equal( %{'hi'}, @a.quote(:s) )
      assert_equal( %{'hi'}, @a.quote(:single) )
    end

    def test_005
      assert_equal( %{`hi`}, @a.quote(:b) )
      assert_equal( %{`hi`}, @a.quote(:back) )
    end

  end

=end

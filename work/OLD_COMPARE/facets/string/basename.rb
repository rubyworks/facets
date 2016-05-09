
class String

  # Removes prepend module namespace.
  #
  #   "Test::Unit".basename  #=> "Unit"
  #
  def basename
    self.to_s.gsub(/^.*::/, '')
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

    def test_001
      assert_equal( "Unit", "Test::Unit".basename )
    end

    def test_002
      a =  "Down::Bottom"
      assert_raises( ArgumentError ) { a.basename(1) }
    end

    def test_003
      a =  "Down::Bottom"
      assert_equal( "Bottom", a.basename )
    end

    def test_004
      b =  "Further::Down::Bottom"
      assert_equal( "Bottom", b.basename )
    end

  end

=end


class String

  # Replaces underscores with spaces and capitalizes word.
  #
  def humanize
    self.gsub(/_/, " ").capitalize
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

    def test_humanize
      assert_equal( 'This is it', 'this_is_it'.humanize )
    end

  end

=end

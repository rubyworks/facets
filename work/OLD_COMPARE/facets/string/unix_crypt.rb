
require 'facets/string/rand_letter'

class String

  # Common Unix cryptography method.
  def unix_crypt
    self.crypt(String.rand_letter + String.rand_letter)
  end

  # Common Unix cryptography in-place method.
  def unix_crypt!
    self.replace(unix_crypt)
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

    def test_unix_crypt
      assert_nothing_raised { "abc 123".unix_crypt }
    end

    def test_unix_crypt!
      assert_nothing_raised { "abc 123".unix_crypt! }
    end

  end

=end

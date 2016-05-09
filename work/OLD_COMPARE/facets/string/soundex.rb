
class String

  # Implementation of the soundex algorithm as described by Knuth
  # in volume 3 of The Art of Computer Programming. Returns nil
  # if the value couldn't be calculated b/c of empty-string or
  # invalid character.
  #
  #   "Ruby".soundex  #=> "R100"
  #
  #--
  # Credit goes to Michael Neumann (neumann@s-direktnet.de).
  #++
  def soundex
    return nil if self.empty?

    str = self.upcase
    last_code = String.soundex_code(str[0,1])
    soundex_code = str[0,1]

    for index in 1...(str.size) do
      return soundex_code if soundex_code.size == 4

      code = String.soundex_code(str[index,1])

      if code == "0" then
        last_code = nil
      elsif code == nil then
        return nil
      elsif code != last_code then
        soundex_code += code
        last_code = code
      end
    end

    return soundex_code + "000"[0,4-soundex_code.size]
  end

  # Support function for String#soundex. Returns code for a single character.
  def String.soundex_code(character)
    character.tr! "AEIOUYWHBPFVCSKGJQXZDTLMNR", "00000000111122222222334556"
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

    def test_soundex
      assert_equal("Ruby".soundex, "R100")
    end

  end

  class TC_Soundex < Test::Unit::TestCase

    TESTVEC = "Euler Ellery Gauss Ghosh Hilbert Heilbronn Knuth Kant Lloyd Ladd Lukasiewicz Lissajous".split(" ")
    RESVEC  = "E460 E460 G200 G200 H416 H416 K530 K530 L300 L300 L222 L222".split(" ")

    def test_soundex
      TESTVEC.each_with_index {|str,i| 
        res = str.soundex
        #print "#{str.ljust(11)} => #{res} ... "
        assert_equal( RESVEC[i], res )
      }
    end

  end

=end


# if __FILE__ == $0
#   testvec = "Euler Ellery Gauss Ghosh Hilbert Heilbronn Knuth Kant Lloyd Ladd Lukasiewicz Lissajous".split(" ")
#   resvec  = "E460 E460 G200 G200 H416 H416 K530 K530 L300 L300 L222 L222".split(" ")
#    
#   wrong = 0
#   
#   testvec.each_with_index {|str,i|
#     res = str.soundex
#     print "#{str.ljust(11)} => #{res} ... "
#     if res == resvec[i] then
#       puts "ok"
#     else
#       wrong += 1
#       puts "failed, had to be #{resvec[i]}"
#     end
#   }
#   puts "summary: #{wrong} of #{testvec.size} tests failed!"
#   readline
# end



class String

  # Scramble the inner characters of words leaving the text still readable
  # (research at Cambridge University, code by KurtDresner).
  #
  # For example, the above text may result in:
  #
  #   Srblamce the iennr cchrteaars of wodrs lvenaig the txet stlil rbeaadle
  #   (rreceash at Cbamigdre Uverintisy, cdoe by KrneruestDr?)
  #
  def dresner
    self.gsub(/\B\w+\B/){$&.split(//).sort_by{rand}} 
  end

  # Inplace version of #dresner method.
  #
  def dresner!
    self.replace(dresner)
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

    def test_dresner
      # assert_still_legible ;-)
      assert_nothing_raised { "How are you today?".dresner }
    end

    def test_dresner
      # assert_still_legible ;-)
      assert_nothing_raised { "How are you today?".dresner! }
    end

  end

=end

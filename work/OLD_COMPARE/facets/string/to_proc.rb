
class String

  # Evaluates a String as a Proc.
  #
  #   xyp = "|x,y| x + y".to_proc
  #   xyp.class      #=> Proc
  #   xyp.call(1,2)  #=> 3
  #
  #--
  # Note: Sure would be nice if this could
  # grab the caller's context!
  #++
  def to_proc(context=nil)
    if context
      if context.kind_of?(Binding) or context.kind_of?(Proc)
        Kernel.eval "proc { #{self} }", context
      else context
        context.instance_eval "proc { #{self} }"
      end
    else
      Kernel.eval "proc { #{self} }"
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

    def test_to_proc
      assert_nothing_raised { @add = '|x,y| x + y'.to_proc }
      assert_equal(4, @add.call(2,2))    
      @t = 3
      @multi = '|y| @t * y'.to_proc(self)
      assert_equal(6, @multi.call(2))
      x = 4
      @div = '|y| x / y'.to_proc(binding)
      assert_equal(2, @div.call(2))
    end

  end

=end

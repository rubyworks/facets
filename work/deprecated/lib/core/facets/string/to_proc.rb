class String

  # Evaluates a String as a Proc.
  #
  #   xyp = "|x,y| x + y".to_proc
  #   xyp.class      #=> Proc
  #   xyp.call(1,2)  #=> 3
  #
  #   each &"|x| x + 1"
  #
  # vs.
  #
  #    each{|x| eval "x + 1"}
  #
  #   NOTE: Sure would be nice if this could grab the caller's context!
  #
  # CREDIT: Trans

  def to_proc(context=nil)
    if context
      if context.kind_of?(Binding) or context.kind_of?(Proc)
        Kernel.eval "proc{ #{self} }", context
      else #context
        context.instance_eval "proc { #{self} }"
      end
    else
      Kernel.eval "proc{ #{self} }"  #, Binding.of_caller
    end
  end

end


__END__

require 'test/unit'

class TestStringConversion < Test::Unit::TestCase

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


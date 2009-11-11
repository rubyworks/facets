module Kernel


  # Evaluate code in a metaclass. This is equivalent to
  # 'meta_class.instance_eval'.
  #
  # CREDIT: WhyTheLuckyStiff

  def meta_eval(str=nil, &blk)
    if str
      meta_class.instance_eval(str)
    else
      meta_class.instance_eval(&blk)
    end
  end

end


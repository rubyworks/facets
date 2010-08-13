module Kernel

  # Evaluate code in a metaclass. This is equivalent to
  # 'meta_class.instance_eval'.
  #
  # CREDIT: WhyTheLuckyStiff

  def meta_eval(str=nil, *file_and_line, &blk)
    if str
      meta_class.instance_eval(str, *file_and_line)
    else
      meta_class.instance_eval(*file_and_line, &blk)
    end
  end

end


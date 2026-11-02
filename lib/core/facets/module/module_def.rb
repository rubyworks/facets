class Module

  # Defines an instance method within a class/module.
  #
  # CREDIT: WhyTheLuckyStiff

  def class_def name, &blk
    class_eval { define_method name, &blk }
  end

  # Defines an instance method within a class/module.
  #
  # CREDIT: WhyTheLuckyStiff

  def module_def name, &blk
    module_eval { define_method name, &blk }
  end

end


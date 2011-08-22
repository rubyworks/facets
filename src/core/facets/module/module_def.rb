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

  #--
  # TODO: Why are we making these protected,
  # and where should these really go in Facets?
  #++
  protected :attr
  protected :attr_reader
  protected :attr_writer
  protected :attr_accessor
  protected :remove_method
  protected :undef_method

end


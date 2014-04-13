class Object

  # Defines an instance method within a class.
  def class_def name, &blk
    class_eval { define_method name, &blk }
  end

end


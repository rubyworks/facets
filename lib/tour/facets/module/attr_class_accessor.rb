class Module

  #
  def attr_class_accessor(name)
    attr_class_reader(name)
    attr_class_writer(name)
  end

  #
  def attr_class_reader(name)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def self.#{name}
        @#{name}
      end
      def #{name}
        self.class.#{name}
      end
    EOS
  end

  #
  def attr_class_writer(name)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def self.#{name}=(x)
        @#{name} = x
      end
      def #{name}=(x)
        self.class.#{name} = x
      end
    EOS
  end

end

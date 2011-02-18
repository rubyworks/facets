class Module

  #
  def class_accessor(name)
    class_reader(name)
    class_writer(name)
  end

  #
  def class_reader(name)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def self.#{name}
        @#{name}
      end
    EOS
  end

  #
  def class_writer(name)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def self.#{name}=(x)
        @#{name} = x
      end
    EOS
  end

end

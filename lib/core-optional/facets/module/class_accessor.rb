class Module

  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  def class_accessor(name)
    class_reader(name)
    class_writer(name)
  end

  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  def class_reader(name)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def self.#{name}
        @#{name}
      end
    EOS
  end

  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  def class_writer(name)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def self.#{name}=(x)
        @#{name} = x
      end
    EOS
  end

end

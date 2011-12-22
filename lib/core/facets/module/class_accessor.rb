class Module

  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/module/class_accessor'
  #
  def class_accessor(name)
    class_reader(name)
    class_writer(name)
  end

  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/module/class_reader'
  #
  def class_reader(name)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def self.#{name}
        @#{name}
      end
    EOS
  end

  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/module/class_writer'
  #
  def class_writer(name)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def self.#{name}=(x)
        @#{name} = x
      end
    EOS
  end

end


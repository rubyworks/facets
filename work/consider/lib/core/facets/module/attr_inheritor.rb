class Module

  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @non-core
  #   require 'facets/module/attr_inheritor'
  #
  def attr_inheritor(name, default)
    copy_inheritor(name, default)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def #{name}
        self.class.#{name}
      end
    EOS
  end

  alias :attr_inheritable_reader, :attr_inheritor
end

class Module

  #
  # NOTE: This is not (presently) a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  def attr_inheritable_reader(name, default)
    copy_inheritor(name, default)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def #{name}
        self.class.#{name}
      end
    EOS
  end

end

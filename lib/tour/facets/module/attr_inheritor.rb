class Module

  #
  def attr_inheritable_reader(name, default)
    copy_inheritor(name, default)
    module_eval(<<-EOS, __FILE__, __LINE__)
      def #{name}
        self.class.#{name}
      end
    EOS
  end

end

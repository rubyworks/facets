class Module

  def instance_class_method(*method_names)
    method_names.each do |method_name|
      define_method(method_name) do
        self.class.send(method_name)
      end
    end
  end

end

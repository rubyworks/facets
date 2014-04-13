class Module

  def bool_accessor(*attrs)
    attrs.each do |attr|
      attr_writer(attr)
      bool_reader(attr)
    end
  end

  def bool_reader(*attrs)
    attrs.each do |attr|
      attr_reader attr
      define_method("#{attr}?") do
        !!send(attr)
      end
    end
  end

end

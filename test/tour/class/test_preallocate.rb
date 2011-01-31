covers 'facets/class/preallocate'

tests Class do

  c = Class.new do
    def f
      "f"
    end
  end

  m = Module.new do
    def f
      '{' + super + '}'
    end
  end

  #
  unit :preallocate do
    c.class_eval do
      preallocate m
    end
    x = c.new
    x.f.assert == "{f}"
  end

end




  class Hash
    def to_module(module_function=false)
      m = Module.new
      each do |k,v| 
        m.send(:define_method, k){ v }
        m.send(:module_function, k) if module_function
      end
      return m
    end
  end

  M = { :a => 1 }.to_module(true)
  p M.a  #=> 1


  class Foo
    def initialize( settings )
      extend settings.to_module
    end
  end

  f = Foo.new(:x => 9)
  p f.x  #=> 9


covers 'facets/class/preallocate'

test_case Class do

  method :preallocate do

    setup do
      @c = Class.new do
        def f
          "f"
        end
      end

      @m = Module.new do
        def f
          '{' + super + '}'
        end
      end
    end

    test do
      m = @m
      @c.class_eval do
        preallocate m
      end
      x = @c.new
      x.f.assert == "{f}"
    end

  end

end

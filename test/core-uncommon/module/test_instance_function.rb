covers 'facets/module/instance_function'

test_case Module do

  method :instance_function do

    setup "using instance_function" do
      @m = Module.new do
        instance_function
        def self.jumble(obj, arg)
          obj + arg
        end
      end
    end

    test "class method" do
      r = @m.jumble('Try', 'Me')
      r.assert == 'TryMe'
    end

    test "instance method" do
      s = 'Try'
      s.extend @m
      r = s.jumble('Me')
      r.assert == 'TryMe'
    end

  end

end

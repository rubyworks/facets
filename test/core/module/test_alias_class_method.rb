covers 'facets/module/alias_class_method'

test_case Module do

  method :alias_class_method do

    test do
      c = Class.new do
        def self.hello; "hello"; end
        alias_class_method :hi, :hello
      end
      c.hi.assert == "hello"
    end

    test "with an explicit receiver" do
      c = Class.new{ def self.hello; "hello"; end }
      c.alias_class_method(:hi, :hello)
      c.hi.assert == "hello"
    end

  end

end

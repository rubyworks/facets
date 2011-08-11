covers 'facets/kernel/__get__'
covers 'facets/kernel/__set__'

test_case Kernel do

  method :__get__ do

    setup "an object with an instance variable" do
      c = Class.new do
        attr :a
        def initialize
          @a = 1
        end
      end
      @o = c.new
    end

    test do
      @o.__get__('@a').assert == 1
    end

    # TODO: support is being considered
    #test "wihtout at-sign" do |o|
    #  o.__get__(:a).assert == 1
    #end

  end

  method :__set__ do

    setup "an object with an instance variable" do
      c = Class.new do
        attr :a
        def initialize
          @a = 1
        end
      end
      @o = c.new
    end

    test do
      @o.__set__('@a', 2)
      @o.a.assert == 2
    end

    # TODO: support is being considered
    #test "without at-sign" do
    #  @o.__set__(:a, 3)
    #  @o.a.assert == 3
    #end

  end

end

covers 'facets/mirror'

test_case Kernel::Mirror do

  song_class = Class.new do
    def initialize(title, year)
      @title, @year = title, year
    end
  end

  # An object that lies about itself through the methods Ruby uses for
  # reflection.
  liar_class = Class.new do
    def initialize; @secret = 42; end
    def class; String; end
    def instance_variables; []; end
    def instance_variable_get(name); :lie; end
    def is_a?(mod); true; end
  end

  method :keys do
    test "gives instance variable names without the @" do
      Mirror.new(song_class.new("Paranoid", 1970)).keys.assert == [:title, :year]
    end
  end

  method :variables do
    test "gives instance variable names as Ruby does" do
      Mirror.new(song_class.new("Paranoid", 1970)).variables.assert == [:@title, :@year]
    end
  end

  method :values do
    test "gives instance variable values in order" do
      Mirror.new(song_class.new("Paranoid", 1970)).values.assert == ["Paranoid", 1970]
    end
  end

  method :size do
    test "counts instance variables" do
      Mirror.new(song_class.new("Paranoid", 1970)).size.assert == 2
      Mirror.new(Object.new).size.assert == 0
    end
  end

  method :each do
    test "yields names and values, so to_h works" do
      Mirror.new(song_class.new("Paranoid", 1970)).to_h.assert == {title: "Paranoid", year: 1970}
    end

    test "returns an enumerator without a block" do
      Mirror.new(song_class.new("Paranoid", 1970)).each.to_a.assert == [[:title, "Paranoid"], [:year, 1970]]
    end
  end

  method :get do
    test "takes names with or without the @" do
      m = Mirror.new(song_class.new("Paranoid", 1970))
      m.get(:title).assert == "Paranoid"
      m.get(:@title).assert == "Paranoid"
      m.get("year").assert == 1970
    end

    test "gives nil for a variable that isn't set" do
      Mirror.new(Object.new).get(:nope).assert == nil
    end
  end

  method :[] do
    test "is get" do
      Mirror.new(song_class.new("Paranoid", 1970))[:title].assert == "Paranoid"
    end
  end

  method :set do
    test "sets a variable and returns the value" do
      song = song_class.new("Paranoid", 1970)
      Mirror.new(song).set(:year, 1971).assert == 1971
      song.instance_variable_get(:@year).assert == 1971
    end
  end

  method :[]= do
    test "is set" do
      song = song_class.new("Paranoid", 1970)
      Mirror.new(song)[:title] = "War Pigs"
      song.instance_variable_get(:@title).assert == "War Pigs"
    end
  end

  method :update do
    test "sets variables from a hash and returns the mirror" do
      song = song_class.new("Paranoid", 1970)
      m = Mirror.new(song)
      m.update(title: "War Pigs", "@year" => 1971).equal?(m).assert == true
      m.to_h.assert == {title: "War Pigs", year: 1971}
    end
  end

  method :key? do
    test "tells whether a variable is set" do
      m = Mirror.new(song_class.new("Paranoid", 1970))
      m.key?(:title).assert == true
      m.key?(:nope).assert == false
    end
  end

  method :remove do
    test "removes a variable and returns its value" do
      m = Mirror.new(song_class.new("Paranoid", 1970))
      m.remove(:year).assert == 1970
      m.keys.assert == [:title]
    end

    test "raises NameError for a variable that isn't set" do
      NameError.assert.raised? { Mirror.new(Object.new).remove(:nope) }
    end
  end

  method :eval do
    test "evaluates a block with the object as self" do
      Mirror.new(song_class.new("Paranoid", 1970)).eval { @title }.assert == "Paranoid"
    end

    test "evaluates a string" do
      Mirror.new(song_class.new("Paranoid", 1970)).eval("@year").assert == 1970
    end
  end

  method :exec do
    test "passes arguments to the block" do
      Mirror.new(song_class.new("Paranoid", 1970)).exec(1) { |n| @year + n }.assert == 1971
    end
  end

  method :object do
    test "is the reflected object" do
      song = song_class.new("Paranoid", 1970)
      Mirror.new(song).object.equal?(song).assert == true
    end
  end

  method :object_class do
    test "gives the true class" do
      Mirror.new(liar_class.new).object_class.assert == liar_class
    end
  end

  method :of? do
    test "checks the exact class" do
      m = Mirror.new(song_class.new("Paranoid", 1970))
      m.of?(song_class).assert == true
      m.of?(Object).assert == false
    end
  end

  method :is? do
    test "checks the class and its ancestors" do
      m = Mirror.new("x")
      m.is?(String).assert == true
      m.is?(Comparable).assert == true
      m.is?(Integer).assert == false
      Mirror.new(liar_class.new).is?(Integer).assert == false
    end
  end

  method :id do
    test "is the object's object_id" do
      o = Object.new
      Mirror.new(o).id.assert == o.object_id
    end
  end

  method :method_names do
    test "gives method names, by kind" do
      o = Object.new
      def o.hi; end
      m = Mirror.new(o)
      m.method_names.assert.include?(:hi)
      m.method_names(:singleton).assert == [:hi]
      m.method_names(:private).assert.include?(:puts)
      m.method_names(:public).refute.include?(:puts)
      m.method_names(:all).assert.include?(:puts)
    end

    test "raises ArgumentError for an unknown kind" do
      ArgumentError.assert.raised? { Mirror.new(Object.new).method_names(:nope) }
    end
  end

  method :method_object do
    test "gives a Method" do
      Mirror.new("abc").method_object(:upcase).call.assert == "ABC"
    end
  end

  method :method_definitions do
    test "lists a module's instance methods" do
      mod = Module.new do
        def a; end
        private def b; end
      end
      m = Mirror.new(mod)
      m.method_definitions.assert == [:a]
      m.method_definitions(:private).assert == [:b]
      m.method_definitions(:all).sort.assert == [:a, :b]
    end

    test "raises TypeError for an object that isn't a module" do
      TypeError.assert.raised? { Mirror.new(Object.new).method_definitions }
    end
  end

  method :method_definition do
    test "gives an UnboundMethod" do
      Mirror.new(String).method_definition(:upcase).owner.assert == String
    end
  end

  method :== do
    test "is true for mirrors of the same object" do
      o = Object.new
      (Mirror.new(o) == Mirror.new(o)).assert == true
    end

    test "is false for mirrors of equal but separate objects" do
      (Mirror.new("x".dup) == Mirror.new("x".dup)).assert == false
    end
  end

  method :hash do
    test "lets mirrors of the same object be hash keys" do
      o = Object.new
      {Mirror.new(o) => 1}[Mirror.new(o)].assert == 1
    end
  end

  method :inspect do
    test "doesn't call the object's own inspect" do
      Mirror.new(BasicObject.new).inspect.assert =~ /\A#<Kernel::Mirror of #<BasicObject:0x\h+>>\z/
    end
  end

  class_method :new do
    test "works on an object that lies about itself" do
      m = Mirror.new(liar_class.new)
      m.keys.assert == [:secret]
      m[:secret].assert == 42
    end

    test "works on a BasicObject" do
      m = Mirror.new(BasicObject.new)
      m[:x] = 1
      m.to_h.assert == {x: 1}
      m.object_class.assert == BasicObject
    end
  end

end

test_case Kernel do

  method :mirror do
    test "gives a mirror of the object" do
      o = Object.new
      o.mirror.assert.is_a?(Kernel::Mirror)
      o.mirror.object.equal?(o).assert == true
    end
  end

end

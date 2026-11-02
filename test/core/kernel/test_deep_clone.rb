covers 'facets/kernel/deep_clone'

test_case Kernel do

  method :deep_clone do

    setup "a class with reference to another class" do
      xC = Class.new do
        attr_reader :x
        def initialize
          @x = 1
        end
      end

      @c = Class.new do
        attr_reader :y
        define_method(:initialize) do
          @y = xC.new
        end
      end
    end

    test do
      o = @c.new
      d = o.deep_clone
      d.y.x.assert == 1
    end

    test "copies nested arrays (#11)" do
      a = [1, [2, [3]]]
      d = a.deep_clone
      d[1][1] << 4
      a.assert == [1, [2, [3]]]
    end

    test "copies hash values" do
      h = {:a => {:b => [1]}}
      d = h.deep_clone
      d[:a][:b] << 2
      h.assert == {:a => {:b => [1]}}
    end

    test "copies collections held in instance variables" do
      c = Class.new do
        attr_reader :list
        def initialize; @list = [[1]]; end
      end
      o = c.new
      d = o.deep_clone
      d.list[0] << 2
      o.list.assert == [[1]]
    end

    test "keeps a hash's default proc" do
      h = Hash.new{ |hash, k| hash[k] = [] }
      d = h.deep_clone
      d[:a] << 1
      d.assert == {:a => [1]}
      h.assert == {}
    end

    test "copies a frozen array and keeps it frozen" do
      a = [[1]].freeze
      d = a.deep_clone
      d.frozen?.assert == true
      d[0] << 2
      a.assert == [[1]]
    end

    test "copies equal but distinct objects separately" do
      a = [String.new("x"), String.new("x")]
      d = a.deep_clone
      d[0].equal?(d[1]).assert == false
    end

    test "handles an array that contains itself" do
      a = [1]
      a << a
      d = a.deep_clone
      d[1].equal?(d).assert == true
    end

  end

end

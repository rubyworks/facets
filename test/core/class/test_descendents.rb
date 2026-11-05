covers 'facets/class/descendants'

test_case Class do

  method :descendants do

    a = Class.new
    b = Class.new(a)
    c = Class.new(b)

    test do
      a.descendants.assert.include?(b)
      a.descendants.assert.include?(c)
    end

    test "limits the generations" do
      a.descendants(1).assert == [b]
      a.descendants(2).sort_by(&:object_id).assert == [b, c].sort_by(&:object_id)
    end

    test "lists all subclasses before their own descendants, as ActiveSupport does" do
      x = Class.new
      y1 = Class.new(x)
      y2 = Class.new(x)
      z = Class.new(y1)
      list = x.descendants
      list.first(2).sort_by(&:object_id).assert == [y1, y2].sort_by(&:object_id)
      list.last.assert == z
    end

    test "doesn't call #descendants on subclasses, which ActiveSupport replaces" do
      x = Class.new
      y = Class.new(x)
      z = Class.new(y)
      def y.descendants
        raise "called"
      end
      x.descendants.assert == [y, z]
    end

  end

end

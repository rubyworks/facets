covers 'facets/module/memoize'

test_case Module do

  method :memoize  do

    test do
      tc = Class.new do
        def initialize(a)
          @a = a
        end
        def a
          "#{@a ^ 3 + 4}"
        end
        memoize :a
      end

      t1 = tc.new(1)
      t2 = tc.new(2)
      t3 = tc.new(3)

      t1.a.assert == "6"
      t2.a.assert == "5"
      t3.a.assert == "4"

      t1.a.__id__.assert == t1.a.__id__
      t2.a.__id__.assert == t2.a.__id__
      t3.a.__id__.assert == t3.a.__id__
    end

  end

end

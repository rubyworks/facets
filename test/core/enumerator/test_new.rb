covers 'facets/enumerator'

test_case Enumerator do

  class_method :new do

    test "with block" do
      # This example taken from ri19 Enumerator.new
      fib = Enumerator.new do |y|
       a = b = 1
        loop {
          y << a
          a, b = b, a + b
        }
      end
      fib.take(10).assert == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    end

  end

end

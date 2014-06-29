if defined?(Enumerator::Lazy)
  covers 'facets/enumerator/lazy/squeeze'

  test_case Enumerator::Lazy do

    method :squeeze do

      # make an Enumerable class to test
      eC = Class.new do
        include Enumerable
        def initialize(*a)
          @a = a
        end
        def each(&b)
          @a.each(&b)
        end
      end

      test 'example (default)' do
        e = eC.new(1,2,2,3,3,2,1)
        e.lazy.squeeze.to_a.assert == [1,2,3,2,1]
      end

      test 'example (with argument)' do
        e = eC.new(1,2,2,3,3,2,1)
        e.lazy.squeeze(*[3]).to_a.assert == [1,2,2,3,2,1]
      end

    end

  end

end

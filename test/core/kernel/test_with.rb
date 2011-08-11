covers 'facets/kernel/with'

test_case Kernel do

  method :with do

    test do
      with values = [] do
        self << 'bar'
        self << 'baz'
      end
      values.assert == ['bar', 'baz']
    end

  end

end


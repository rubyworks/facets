covers 'facets/kernel/complete'

test_case Kernel do

  method :complete do

    test do
      a = []
      i = 0
      complete do
        i += 1
        i == 3 ? nil : a << i
      end
      a.assert == [1,2]
    end

  end

end

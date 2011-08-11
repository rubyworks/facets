covers 'facets/kernel/not'

test_case Kernel do

  method :not? do

    test do
      b = true
      b.not?.assert == !b
    end

    test :not? do
      b = false
      b.not?.assert == !b
    end

    test :not? do
      b = nil
      b.not?.assert == !b
    end

    test :not? do
      b = Object.new
      b.not?.assert == !b
    end

  end

  method :not do

    test do
      b = true
      r = b.not.nil?
      r.assert == true
    end

    test :not do
      b = false
      r = b.not.nil?
      r.assert == true
    end

    test :not do
      b = nil
      r = b.not.nil?
      r.assert == false
    end

  end

end

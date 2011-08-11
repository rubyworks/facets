covers 'facets/kernel/not_nil'

test_case Kernel do

  method :not_nil? do

    test do
      5.assert.not_nil?
    end

    test do
      :x.assert.not_nil?
    end

    test do
      false.assert.not_nil?
    end

    test do
      nil.refute.not_nil?
    end

  end

end

covers 'facets/kernel/here'

test_case Kernel do

  method :here do

    test do
      here.assert.is_a?(Binding)
    end

  end

end

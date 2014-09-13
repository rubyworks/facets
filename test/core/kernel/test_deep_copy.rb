covers 'facets/kernel/deep_copy'

test_case Kernel do

  method :deep_copy do

    test do
      o = "This is a weak test."
      d = o.deep_copy
      d.assert == "This is a weak test."
    end

  end

end

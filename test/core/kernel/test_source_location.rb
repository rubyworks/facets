covers 'facets/kernel/source_location'

test_case Kernel do

  # TODO: lemon seems to interfer with call stack

  method :source_location do

    test do
      raise Omission, "issue with call stack"

      file, line, meth = source_location_example
      file.assert == __FILE__
      line.assert == 13
      meth.assert == :source_location_example
    end

    # helper method
    def source_location_example
      source_location
    end

  end

end

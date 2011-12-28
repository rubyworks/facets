covers 'facets/kernel/constant'

test_case Kernel do

  method :constant do

    test do
      c = ::Lemon::TestCase.name
      constant(c).assert == ::Lemon::TestCase

      c = "TestCase"
      ::Lemon.constant(c).assert == ::Lemon::TestCase
    end

  end

end


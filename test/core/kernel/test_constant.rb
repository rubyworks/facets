covers 'facets/kernel/constant'

tests Kernel do

  unit :constant do
    c = Lemon::TestCase.name
    constant(c).assert == Lemon::TestCase

    c = "TestCase"
    Lemon.constant(c).assert == Lemon::TestCase
  end

end


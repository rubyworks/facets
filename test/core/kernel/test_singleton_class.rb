covers 'facets/kernel/singleton_class'

tests Kernel do

  unit :singleton_class do
    x = Class.new
    m = (class << x; self; end)
    x.singleton_class.assert == m
  end

end

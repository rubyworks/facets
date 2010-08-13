covers 'facets/kernel/with'

tests Kernel do

  unit :with do
    with values = [] do
      self << 'bar'
      self << 'baz'
    end
    values.assert == ['bar', 'baz']
  end

end


covers 'facets/kernel/here'

tests Kernel do

  unit :here do
    here.assert.is_a?(Binding)
  end

end

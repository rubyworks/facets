covers 'facets/kernel/complete'

tests Kernel do

  unit :complete do
    a = []
    i = 0
    complete do
      i += 1
      i == 3 ? nil : a << i
    end
    a.assert == [1,2]
  end

end

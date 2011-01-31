covers 'facets/kernel/not'

tests Kernel do

  unit :not? do
    b = true
    b.not?.assert == !b
  end

  unit :not? do
    b = false
    b.not?.assert == !b
  end

  unit :not? do
    b = nil
    b.not?.assert == !b
  end

  unit :not? do
    b = Object.new
    b.not?.assert == !b
  end

  unit :not do
    b = true
    r = b.not.nil?
    r.assert == true
  end

  unit :not do
    b = false
    r = b.not.nil?
    r.assert == true
  end

  unit :not do
    b = nil
    r = b.not.nil?
    r.assert == false
  end

end


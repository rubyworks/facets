covers 'facets/module/anonymous'

tests Module do

  unit :anonymous? do
    m = Module.new
    m.assert.anonymous?
  end

  unit :anonymous? do
    Lemon.refute.anonymous?
  end

end

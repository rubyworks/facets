covers 'facets/kernel/extension'

tests Kernel do

  # DEPRECATE ?
  unit :extension do
    c = Class.new
    o = c.new
    x = (class << o; self; end)
    o.extension.assert == x
  end

end


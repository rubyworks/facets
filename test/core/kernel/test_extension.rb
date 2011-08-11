covers 'facets/kernel/extension'

test_case Kernel do

  # DEPRECATE ?
  method :extension do

    test do
      c = Class.new
      o = c.new
      x = (class << o; self; end)
      o.extension.assert == x
    end

  end

end


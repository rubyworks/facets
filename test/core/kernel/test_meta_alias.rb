covers 'facets/kernel/meta_alias'

test_case Kernel do

  method :meta_alias do

    test do
      c = Class.new do
        def self.y?; "y?" ; end
      end
      c.meta_alias "ynot?", "y?"
      c.ynot?.assert == "y?"
    end

  end

end


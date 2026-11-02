covers 'facets/module/module_def'

test_case Module do

  method :module_def do

    test do
      m = Module.new
      m.module_def(:x){"x"}
      c = Class.new{ include m }
      c.new.x.assert == "x"
    end

    test do
      c = Class.new
      c.module_def(:x){"x"}
      c.new.x.assert == "x"
    end

  end

  # Facets used to make these protected (#292). Ruby has made them public
  # since 2.5.
  method :module_def do
    test "leaves Ruby's Module methods public" do
      Module.new.module_def(:x){"x"}
      %w[attr attr_reader attr_writer attr_accessor remove_method undef_method].each do |m|
        Module.public_method_defined?(m).assert == true
      end
    end
  end

end

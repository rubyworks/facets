covers 'facets/pathname/chdir'

test_case Pathname do

  method :chdir do

    test do
      Pathname.pwd.basename.to_s.assert != 'tmp'
      Pathname.new('tmp').chdir do
        Pathname.pwd.basename.to_s.assert == 'tmp'
      end
    end

  end
end


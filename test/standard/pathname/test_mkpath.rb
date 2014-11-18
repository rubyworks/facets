covers 'facets/pathname/mkpath'

test_case Pathname do

  method :mkpath? do

    setup do
      @test_dir = Pathname.new('tmp/dir/to/test')
      @test_dir.rmtree if @test_dir.exist?
    end

    test do
      @test_dir.exist?.assert == false
      @test_dir.mkpath?
      @test_dir.exist?.assert == true
      @test_dir.mkpath?
    end

  end
end




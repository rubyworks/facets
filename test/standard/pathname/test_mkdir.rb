covers 'facets/pathname/mkdir'

test_case Pathname do

  method :mkdir? do

    setup do
      @test_dir = Pathname.new('tmp/dir_to_test')
      @test_dir.rmtree if @test_dir.exist?
    end

    test do
      @test_dir.exist?.assert == false
      @test_dir.mkdir?
      @test_dir.exist?.assert == true
      @test_dir.mkdir?
    end

  end
end


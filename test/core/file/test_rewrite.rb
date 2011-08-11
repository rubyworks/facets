covers 'facets/file/rewrite'

test_case File do

  test_data = 'This is a test!'

  class_method :rewrite do

    setup do
      @test_file = 'tmp/rewrite.txt'
      File.open(@test_file, 'w'){ |w| w << test_data }
    end

    test do
      File.rewrite(@test_file){ |s| s.reverse }
      File.read(@test_file).assert == test_data.reverse
    end

  end

  class_method :rewrite! do

    setup do
      @test_file = 'tmp/rewrite.txt'
      File.open(@test_file, 'w'){ |w| w << test_data }
    end

    test do
      File.rewrite!(@test_file){ |s| s.reverse! }
      File.read(@test_file).assert == test_data.reverse
    end

  end

end

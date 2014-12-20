require 'pathname'

covers 'facets/pathname/readline'

test_case Pathname do

  method :readline do

    setup do
      @test_file = Pathname.new('tmp/test_file')
      File.open(@test_file, "w") { |f| f << "line1\nline2" }
    end

    test do
      @test_file.readline.assert == "line1\n"
    end

  end
end





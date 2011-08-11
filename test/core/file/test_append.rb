covers 'facets/file/append'

test_case File do

  class_method :append do

    setup do
      require 'fileutils'
      @test_file = 'tmp/append.txt'
      FileUtils.rm(@test_file) if File.exist?(@test_file)
    end

    test do
      File.append(@test_file, "line 1\n")
      File.read(@test_file).assert == "line 1\n"
      File.append(@test_file, "line 2\n")
      File.read(@test_file).assert == "line 1\nline 2\n"
    end

  end

end

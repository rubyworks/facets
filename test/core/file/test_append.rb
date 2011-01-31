covers 'facets/file/append'

tests File do

  context do
    test_file = 'tmp/append.txt'
    require 'fileutils'
    FileUtils.rm(test_file) if File.exist?(test_file)
    test_file
  end

  metaunit :append do |test_file|
    File.append(test_file, "line 1\n")
    File.read(test_file).assert == "line 1\n"
    File.append(test_file, "line 2\n")
    File.read(test_file).assert == "line 1\nline 2\n"
  end

end

covers 'facets/file/ext'

test_case File do

  class_method :ext do

    test "typical filename" do
      s = 'file.txt'
      File.ext(s).assert == 'txt'
      File.ext(s, 'old').assert == 'file.old'
      File.ext(s, '').assert == 'file'
    end

    test "no extension" do
      s = 'file'
      File.ext(s).assert == ''
      File.ext(s, 'txt').assert == 'file.txt'
      File.ext(s, '').assert == 'file'
    end 

    test "non-standard extensions" do
      s = '.profile'
      File.ext(s).assert == ''
      File.ext(s, 'new').assert == '.profile.new'
      File.ext(s, '').assert == '.profile'
    end

  end

end


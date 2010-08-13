covers 'facets/file/ext'

tests File do

  metaunit :ext => "typical filename" do
    s = 'file.txt'
    File.ext(s).assert == 'txt'
    File.ext(s, 'old').assert == 'file.old'
    File.ext(s, '').assert == 'file'
  end

  metaunit :ext => "no extension" do
    s = 'file'
    File.ext(s).assert == ''
    File.ext(s, 'txt').assert == 'file.txt'
    File.ext(s, '').assert == 'file'
  end 

  metaunit :ext => "non-standard extensions" do
    s = '.profile'
    File.ext(s).assert == ''
    File.ext(s, 'new').assert == '.profile.new'
    File.ext(s, '').assert == '.profile'
  end

end


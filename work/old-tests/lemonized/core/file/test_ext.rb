require 'facets/file/ext'
require 'test/unit'
 
class Test_File_Ext < Test::Unit::TestCase

  # Standard file names.  
  def test_ext_standard
    s = 'file.txt'
    assert_equal('txt', File.ext(s))
    assert_equal('file.old', File.ext(s, 'old'))
    assert_equal('file', File.ext(s, ''))
  end

  # Initially no extension.
  def test_ext_none
    s = 'file'
    assert_equal('', File.ext(s))
    assert_equal('file.txt', File.ext(s, 'txt'))
    assert_equal('file', File.ext(s, ''))
  end 

  # Some non-standard case.
  def test_ext_non_standard
    s = '.profile'
    assert_equal('', File.ext(s))
    assert_equal('.profile.new', File.ext(s, 'new'))
    assert_equal('.profile', File.ext(s, ''))
  end

end


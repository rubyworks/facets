covers 'facets/dir/multiglob'

tests Dir do

  metaunit :multiglob do
    r = Dir.multiglob('test/c*', 'test/m*').sort
    r.assert == ['test/core', 'test/more']
  end

  metaunit :multiglob_r do
    r = Dir.multiglob_r('test').sort
    r.assert.include?('test/core/dir')
    r.assert.include?('test/core/dir/test_multiglob.rb')
  end

end


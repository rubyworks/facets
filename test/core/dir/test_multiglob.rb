covers 'facets/dir/multiglob'

test_case Dir do

  class_method :multiglob do

    test do
      r = Dir.multiglob('test/c*').sort
      r.assert.include?('test/core')
    end

  end

  class_method :multiglob_r do

    test do
      r = Dir.multiglob_r('test').sort
      r.assert.include?('test/core/dir')
      r.assert.include?('test/core/dir/test_multiglob.rb')
    end

  end

end


covers 'facets/dir/recurse'

test_case Dir do

  class_method :recurse do

    test do
      r = Dir.recurse('test')
      r.assert.include?('test/core/dir')
      r.assert.include?('test/core/dir/test_recurse.rb')
    end

  end

  class_method :ls_r do

    test do
      r = Dir.ls_r('test')
      r.assert.include?('test/core/dir')
      r.assert.include?('test/core/dir/test_recurse.rb')
    end

  end

end


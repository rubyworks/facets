covers 'facets/dir/multiglob'

test_case Dir do

  class_method :multiglob do

    test do
      r = Dir.multiglob('test/c*').sort
      r.assert.include?('test/core')
    end

    test "with :recurse" do
      r = Dir.multiglob('test/core/dir', :recurse => true).sort
      r.assert == Dir.multiglob_r('test/core/dir').sort
      r.assert.include?('test/core/dir/test_multiglob.rb')
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


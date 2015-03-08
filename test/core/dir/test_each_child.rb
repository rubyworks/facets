covers 'facets/dir/each_child'

test_case Dir do

  test_directory = 'test'

  method :each_child do

    test do
      c = []
      d = Dir.new(test_directory)
      d.each_child do |path|
        c << path
      end
      d.close
      (['core', 'standard'] - c).assert.empty?
    end

  end

end


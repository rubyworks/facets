covers 'facets/find/select'

require 'tmpdir'

test_case Find do

  class_method :select do

    test "returns the matching paths" do
      Dir.mktmpdir do |dir|
        File.write(File.join(dir, 'a.rb'), '')
        File.write(File.join(dir, 'b.txt'), '')
        r = Find.select(dir){ |f| f.end_with?('.rb') }
        r.assert == [File.join(dir, 'a.rb')]
      end
    end

    test "supports Find.prune" do
      Dir.mktmpdir do |dir|
        Dir.mkdir(File.join(dir, 'skip'))
        File.write(File.join(dir, 'skip', 'c.rb'), '')
        File.write(File.join(dir, 'a.rb'), '')
        r = Find.select(dir) do |f|
          Find.prune if File.basename(f) == 'skip'
          f.end_with?('.rb')
        end
        r.assert == [File.join(dir, 'a.rb')]
      end
    end

  end

end

covers 'facets/pathname/glob'

require 'tmpdir'

test_case Pathname do

  method :glob do

    test "takes symbol flags" do
      Dir.mktmpdir do |dir|
        File.write("#{dir}/.hidden", "")
        File.write("#{dir}/a.rb", "")
        names = Pathname.new(dir).glob('*', :dotmatch).map { |p| p.basename.to_s }
        names.assert.include?('.hidden')
        names.assert.include?('a.rb')
        Pathname.new(dir).glob('*').map { |p| p.basename.to_s }.refute.include?('.hidden')
      end
    end

    test "gives each match to a block and returns nil, as Ruby's does" do
      Dir.mktmpdir do |dir|
        File.write("#{dir}/a.rb", "")
        File.write("#{dir}/b.rb", "")
        seen = []
        Pathname.new(dir).glob('*.rb') { |p| seen << p.basename.to_s }.assert.nil?
        seen.sort.assert == ['a.rb', 'b.rb']
        seen = []
        Pathname.new(dir).glob('*.rb', :dotmatch) { |p| seen << p.basename.to_s }.assert.nil?
        seen.sort.assert == ['a.rb', 'b.rb']
      end
    end

    test "works in a directory whose name has glob characters" do
      Dir.mktmpdir do |dir|
        Dir.mkdir("#{dir}/x[1]")
        File.write("#{dir}/x[1]/a.rb", "")
        Pathname.new("#{dir}/x[1]").glob('*.rb', :dotmatch).size.assert == 1
      end
    end

  end

end

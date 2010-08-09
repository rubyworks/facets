require 'facets/dir/ascend'
require 'test/unit'
require 'tmpdir'

class TC_Dir_Descend < Test::Unit::TestCase

   def setup
     @location = File.join(Dir.tmpdir, self.class.name, Time.now.usec.to_s)
     @startdir = File.join(@location)
   end

   def test_descend
     c = []
     Dir.descend(@startdir) do |path|
       c << path
     end
     rdir = @startdir
     c.reverse_each do |d|
       assert_equal(rdir, d)
       rdir = File.dirname(rdir)
     end
   end

end


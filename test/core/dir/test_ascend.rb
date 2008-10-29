require 'facets/dir/ascend'
require 'test/unit'
require 'tmpdir'

class TC_Dir_Ascend < Test::Unit::TestCase

   DIRS  = %w{A A/B}
   FILES = %w{A.txt A/B.txt A/B/C.txt}

   def setup
     @location = File.join(Dir.tmpdir, self.class.name, Time.now.usec.to_s)
     @startdir = File.join(@location)
   end

   def test_ascend
     c = []
     Dir.ascend(@startdir) do |path|
       c << path
     end
     rdir = @startdir
     c.each do |d|
       assert_equal(rdir, d)
       rdir = File.dirname(rdir)
     end
   end

   def test_ascend_exclude_current
     c = []
     Dir.ascend(@startdir, false) do |path|
       c << path
     end
     rdir = File.dirname(@startdir)
     c.each do |d|
       assert_equal(rdir, d)
       rdir = File.dirname(rdir)
     end
   end

end


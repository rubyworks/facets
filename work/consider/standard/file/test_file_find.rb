######################################################################
# test_file_find.rb
#
# Test case for the File::Find package. You should run this via the
# 'rake test' task.
######################################################################
require 'rubygems'
gem 'test-unit'

require 'test/unit'
require 'fileutils'
require 'file/find'
require 'rbconfig'

begin
   require 'sys/admin'
rescue LoadError
   require 'etc'
end

include Config
include FileUtils

class TC_File_Find < Test::Unit::TestCase
   def self.startup
      Dir.chdir(File.dirname(File.expand_path(__FILE__)))

      @@windows = CONFIG['host_os'] =~ /windows|mswin/i
      @@jruby   = RUBY_PLATFORM.match('java')

      unless @@windows
         if @@jruby
            @@loguser = Etc.getpwnam(Etc.getlogin)
            @@logroup = Etc.getgrgid(@@loguser.gid)
         else
            @@loguser = Sys::Admin.get_user(Sys::Admin.get_login)
            @@logroup = Sys::Admin.get_group(@@loguser.gid)
         end
      end
   end

   def setup
      @file_rb    = 'test1.rb'
      @file_txt1  = 'test1.txt'
      @file_txt2  = 'foo.txt'
      @file_doc   = 'foo.doc'
      @directory1 = 'dir1'
      @directory2 = 'dir2'

      File.open(@file_rb, 'w'){}
      File.open(@file_txt1, 'w'){}
      File.open(@file_txt2, 'w'){}
      File.open(@file_doc, 'w'){}

      unless @@windows
         @link1 = 'link1'
         File.symlink(@file_rb, @link1)
      end

      Dir.mkdir(@directory1) unless File.exists?(@directory1)
      Dir.mkdir(@directory2) unless File.exists?(@directory2)

      File.open(File.join(@directory1, 'bar.txt'), 'w'){}
      File.open(File.join(@directory2, 'baz.txt'), 'w'){}

      @rule1 = File::Find.new(:name => '*.txt')
      @rule2 = File::Find.new
   end

   def test_version
      assert_equal('0.3.4', File::Find::VERSION)
   end

   def test_path
      assert_respond_to(@rule1, :path)
      assert_respond_to(@rule1, :path=)
      assert_equal(Dir.pwd, @rule1.path)
   end

   def test_options
      assert_respond_to(@rule1, :options)
      assert_respond_to(@rule1, :options=)
      assert_equal({:name => '*.txt'}, @rule1.options)
   end

   def test_atime_basic
      assert_respond_to(@rule1, :atime)
      assert_respond_to(@rule1, :atime=)
      assert_nil(@rule1.atime)
   end

   def test_atime
      rule1 = File::Find.new(:name => "*.rb", :atime => 0)
      rule2 = File::Find.new(:name => "*.rb", :atime => 1)

      assert_false(rule1.find.empty?)
      assert_true(rule2.find.empty?)
   end

   def test_ctime_basic
      assert_respond_to(@rule1, :ctime)
      assert_respond_to(@rule1, :ctime=)
      assert_nil(@rule1.ctime)
   end

   def test_ctime
      rule1 = File::Find.new(:name => "*.rb", :ctime => 0)
      rule2 = File::Find.new(:name => "*.rb", :ctime => 1)

      assert_false(rule1.find.empty?)
      assert_true(rule2.find.empty?)
   end

   def test_find_basic
      assert_respond_to(@rule1, :find)
      assert_nothing_raised{ @rule1.find }
   end

   def test_find
      assert_kind_of(Array, @rule1.find)
      assert_nil(@rule1.find{})
   end

   def test_filetest_basic
      assert_respond_to(@rule1, :filetest)
      assert_respond_to(@rule1, :filetest=)
      assert_nothing_raised{ @rule1.filetest }
      assert_kind_of(Array, @rule1.filetest)
   end

   def test_filetest_valid_options
      assert_nothing_raised{ File::Find.new(:readable? => true) }
      assert_nothing_raised{ File::Find.new(:writable? => true) }
   end

   def test_filetest
      omit_if(@@windows && @@jruby, "Skipping file test on JRuby/Windows")

      rule = File::Find.new(:name => "*.doc", :writable? => true)
      File.chmod(0644, @file_doc)

      assert_equal([@file_doc], rule.find.map{ |f| File.basename(f) })

      File.chmod(0444, @file_doc)

      assert_equal([], rule.find)
   end

   def test_mtime
      rule1 = File::Find.new(:name => "*.rb", :mtime => 0)
      rule2 = File::Find.new(:name => "*.rb", :mtime => 1)

      assert_false(rule1.find.empty?)
      assert_true(rule2.find.empty?)
   end

   def test_mtime_basic
      assert_respond_to(@rule1, :mtime)
      assert_respond_to(@rule1, :mtime=)
      assert_nil(@rule1.mtime)
   end

   def test_ftype_basic
      assert_respond_to(@rule1, :ftype)
      assert_respond_to(@rule1, :ftype=)
      assert_nil(@rule1.ftype)
   end

   def test_ftype
      rule1 = File::Find.new(:name => "*.rb", :ftype => "file")
      rule2 = File::Find.new(:name => "*.rb", :ftype => "characterSpecial")

      assert_false(rule1.find.empty?)
      assert_true(rule2.find.empty?)
   end

   def test_group_basic
      assert_respond_to(@rule1, :group)
      assert_respond_to(@rule1, :group=)
      assert_nil(@rule1.group)
   end

   def test_group_with_numeric_id
      omit_if(@@windows, 'group test skipped on MS Windows')
      @rule1 = File::Find.new(:name => '*.doc', :group => @@loguser.gid)
      assert_equal([File.expand_path(@file_doc)], @rule1.find)
   end

   def test_group_with_string
      omit_if(@@windows, 'group test skipped on MS Windows')
      @rule1 = File::Find.new(:name => '*.doc', :group => @@logroup.name)
      assert_equal([File.expand_path(@file_doc)], @rule1.find)
   end

   def test_group_with_bad_id
      omit_if(@@windows, 'group test skipped on MS Windows')
      @rule1 = File::Find.new(:name => '*.doc', :group => 'totallybogus')
      @rule2 = File::Find.new(:name => '*.doc', :group => 99999999)
      assert_equal([], @rule1.find)
      assert_equal([], @rule2.find)
   end

   def test_inum_basic
      assert_respond_to(@rule1, :inum)
      assert_respond_to(@rule1, :inum=)
      assert_nil(@rule1.inum)
   end

   def test_follow_basic
      assert_respond_to(@rule1, :follow)
      assert_respond_to(@rule1, :follow=)
      assert_true(@rule1.follow)
   end

   def test_links_basic
      assert_respond_to(@rule1, :links)
      assert_respond_to(@rule1, :links=)
      assert_nil(@rule1.links)
   end

   def test_links
      omit_if(@@windows, 'links test skipped on MS Windows')

      @rule1 = File::Find.new(:name => '*.rb', :links => 2)
      @rule2 = File::Find.new(:name => '*.doc', :links => 1)

      assert_equal([], @rule1.find)
      assert_equal([File.expand_path(@file_doc)], @rule2.find)
   end

   def test_maxdepth_basic
      assert_respond_to(@rule1, :maxdepth)
      assert_respond_to(@rule1, :maxdepth=)
      assert_nil(@rule1.maxdepth)
   end
   
   def test_maxdepth_file
      mkpath('a1/a2/a3')
      touch('a1/a.foo')
      touch('a1/a2/b.foo')
      touch('a1/a2/c.foo')
      touch('a1/a2/a3/d.foo')
      touch('a1/a2/a3/e.foo')
      touch('a1/a2/a3/f.foo')
      
      @rule2.pattern = "*.foo"
      @rule2.maxdepth = 1    
      assert_equal([], @rule2.find)
      
      @rule2.maxdepth = 2
      assert_equal(['a.foo'], @rule2.find.map{ |e| File.basename(e) })
      
      @rule2.maxdepth = 3
      assert_equal(['a.foo', 'b.foo', 'c.foo'], @rule2.find.map{ |e| File.basename(e) })
      
      @rule2.maxdepth = nil
      assert_equal(['a.foo', 'b.foo', 'c.foo', 'd.foo', 'e.foo', 'f.foo'], @rule2.find.map{ |e| File.basename(e) })
   end

   def test_maxdepth_directory
      mkpath('a/b/c')
      @rule2.pattern = "c"

      @rule2.maxdepth = 1    
      assert_equal([], @rule2.find)
      
      @rule2.maxdepth = 2
      assert_equal([], @rule2.find)
      
      @rule2.maxdepth = 3
      assert_equal(['c'], @rule2.find.map{ |e| File.basename(e) })
   end

   def test_mindepth_basic
      assert_respond_to(@rule1, :mindepth)
      assert_respond_to(@rule1, :mindepth=)
      assert_nil(@rule1.mindepth)
   end

   def test_mindepth_file
      mkpath('a1/a2/a3')
      touch('z.min')
      touch('a1/a.min')
      touch('a1/a2/b.min')
      touch('a1/a2/c.min')
      touch('a1/a2/a3/d.min')
      touch('a1/a2/a3/e.min')
      touch('a1/a2/a3/f.min')
      
      @rule2.pattern = "*.min"

      @rule2.mindepth = 0
      assert_equal(['z.min', 'a.min', 'b.min', 'c.min', 'd.min', 'e.min', 'f.min'], @rule2.find.map{ |e| File.basename(e) })

      @rule2.mindepth = 1
      assert_equal(['z.min', 'a.min', 'b.min', 'c.min', 'd.min', 'e.min', 'f.min'], @rule2.find.map{ |e| File.basename(e) })

      @rule2.mindepth = 2
      assert_equal(['a.min', 'b.min', 'c.min', 'd.min', 'e.min', 'f.min'], @rule2.find.map{ |e| File.basename(e) })
      
      @rule2.mindepth = 3
      assert_equal(['b.min', 'c.min', 'd.min', 'e.min', 'f.min'], @rule2.find.map{ |e| File.basename(e) })
      
      @rule2.mindepth = 4
      assert_equal(['d.min', 'e.min', 'f.min'], @rule2.find.map{ |e| File.basename(e) })

      @rule2.mindepth = 5
      assert_equal([], @rule2.find.map{ |e| File.basename(e) })
   end

   def test_mindepth_directory
      mkpath('a/b/c')
      @rule2.pattern = "a"

      @rule2.mindepth = 1    
      assert_equal(['a'], @rule2.find.map{ |e| File.basename(e) })
      
      @rule2.mindepth = 2
      assert_equal([], @rule2.find)
      
      @rule2.mindepth = 3
      assert_equal([], @rule2.find)
   end

   def test_mount_basic
      assert_respond_to(@rule1, :mount)
      assert_respond_to(@rule1, :mount=)
      assert_nil(@rule1.mount)
   end

   def test_name_basic
      assert_respond_to(@rule1, :name)
      assert_respond_to(@rule1, :name=)
      assert_equal('*.txt', @rule1.name)
   end

   def test_pattern_alias
      assert_respond_to(@rule1, :pattern)
      assert_respond_to(@rule1, :pattern=)
      assert_true(@rule1.method(:name) == @rule1.method(:pattern))
      assert_true(@rule1.method(:name=) == @rule1.method(:pattern=))
   end

   def test_perm_basic
      assert_respond_to(@rule1, :perm)
      assert_respond_to(@rule1, :perm=)
      assert_nil(@rule1.perm)
   end

   def test_perm
      omit_if(@@windows, 'perm test skipped on MS Windows')
      File.chmod(0664, @file_rb) 
      File.chmod(0644, @file_txt1) 
      results = File::Find.new(:name => "test1*", :perm => 664).find

      assert_equal(1, results.length)
      assert_equal('test1.rb', File.basename(results.first))
   end

   def test_perm_with_symbolic_permissions
      omit_if(@@windows, 'symbolic perm test skipped on MS Windows')

      File.chmod(0664, @file_rb)  # test1.rb
      File.chmod(0644, @file_txt1)  # test1.txt
      results1 = File::Find.new(:name => "test1*", :perm => "g=rw").find
      results2 = File::Find.new(:name => "test1*", :perm => "u=rw").find

      assert_equal(1, results1.length)
      assert_equal(2, results2.length)
      assert_equal('test1.rb', File.basename(results1.first))
      assert_equal(['test1.rb', 'test1.txt'], results2.map{ |e| File.basename(e) })
   end

   def test_prune_basic
      assert_respond_to(@rule1, :prune)
      assert_respond_to(@rule1, :prune=)
      assert_nil(@rule1.prune)
   end

   def test_prune
      rule = File::Find.new(:name => "*.txt", :prune => 'foo')
      assert_equal('test1.txt', File.basename(rule.find.first))
   end

   def test_size_basic
      assert_respond_to(@rule1, :size)
      assert_respond_to(@rule1, :size=)
      assert_nil(@rule1.size)
   end

   def test_user_basic
      assert_respond_to(@rule1, :user)
      assert_respond_to(@rule1, :user=)
      assert_nil(@rule1.user)
   end

   def test_user_with_numeric_id
      omit_if(@@windows, 'user test skipped on MS Windows')
      @rule1 = File::Find.new(:name => '*.doc', :user => @@loguser.uid)
      assert_equal([File.expand_path(@file_doc)], @rule1.find)
   end

   def test_user_with_string
      omit_if(@@windows, 'user test skipped on MS Windows')
      @rule1 = File::Find.new(:name => '*.doc', :user => @@loguser.name)
      assert_equal([File.expand_path(@file_doc)], @rule1.find)
   end

   def test_user_with_bad_id
      omit_if(@@windows, 'user test skipped on MS Windows')
      @rule1 = File::Find.new(:name => '*.doc', :user => 'totallybogus')
      @rule2 = File::Find.new(:name => '*.doc', :user => 99999999)
      assert_equal([], @rule1.find)
      assert_equal([], @rule2.find)
   end

   def test_previous_basic
      assert_respond_to(@rule1, :previous)
   end

   def test_expected_errors
      assert_raise(Errno::ENOENT){ File::Find.new(:path => '/bogus/dir').find }
      assert_raise(ArgumentError){ File::Find.new(:bogus => 1) }
      assert_raise(ArgumentError){ File::Find.new(:bogus? => true) }
   end

   def teardown
      rm_rf(@file_rb)
      rm_rf(@file_txt1)
      rm_rf(@file_txt2)
      rm_rf(@file_doc)
      rm_rf(@directory1)
      rm_rf(@directory2)
      rm_rf(@link1) unless @@windows
      rm_rf('a')
      rm_rf('a1')
      rm_rf('z.min') if File.exists?('z.min')

      @rule1 = nil
      @rule2 = nil
      @file_rb = nil
      @file_txt1 = nil
      @file_txt2 = nil
      @file_doc = nil
   end

   def self.shutdown
      @@windows = nil
      @@jruby   = nil
      @@loguser = nil unless @@windows
      @@logroup = nil unless @@windows
   end
end

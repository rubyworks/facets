require 'facets/dir/multiglob'
require 'ae/legacy'
require 'fileutils'
require 'tmpdir'

Case Dir do

  MULTIGLOB_TESTDIR = File.join(Dir.tmpdir, 'facets', 'dir', 'multiglob', Time.now.usec.to_s)
  MULTIGLOB_DIRS  = %w{A A/B}
  MULTIGLOB_FILES = %w{A.txt A/B.txt A/B/C.txt}

  Unit :multiglob do
   multiglob_setup
   Dir.chdir MULTIGLOB_TESTDIR do
     rs = %w{A A.txt}
     fs = Dir.multiglob('*').sort
     assert_equal( rs, fs, Dir.pwd  )
   end

  end

  Unit :multiglob_r do
    multiglob_setup
    Dir.chdir MULTIGLOB_TESTDIR do
      rs = (MULTIGLOB_DIRS + MULTIGLOB_FILES).sort
      fs = Dir.multiglob_r('*').sort
      assert_equal( rs, fs, Dir.pwd  )
    end
    multiglob_teardown
  end

  #
  def multiglob_setup
    MULTIGLOB_DIRS.each do |x|
      FileUtils.mkdir_p(File.join(MULTIGLOB_TESTDIR, x))
    end
    MULTIGLOB_FILES.each do |x|
      File.open(File.join(MULTIGLOB_TESTDIR, x), 'w'){ |f| f << "SPINICH" }
    end
  end

  def multiglob_teardown
    FileUtils.rm_r(MULTIGLOB_TESTDIR)
  end

end


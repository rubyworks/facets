Covers 'facets/dir/multiglob'

require 'fileutils'
require 'tmpdir'

Case Dir do

  test_directory = File.join(Dir.tmpdir, 'facets', 'dir', 'multiglob', Time.now.usec.to_s)
  multiglob_dirs  = %w{A A/B}
  multiglob_files = %w{A.txt A/B.txt A/B/C.txt}

  Before :multiglob, :multiglob_r do
    multiglob_dirs.each do |x|
      FileUtils.mkdir_p(File.join(test_directory, x))
    end
    multiglob_files.each do |x|
      File.open(File.join(test_directory, x), 'w'){ |f| f << "SPINICH" }
    end
  end

  After :multiglob, :multiglob_r do
    FileUtils.rm_r(test_directory)
  end

  Unit :multiglob do
    Dir.chdir test_directory do
      x = %w{A A.txt}
      r = Dir.multiglob('*').sort
      r.assert == x
    end
  end

  Unit :multiglob_r do
    Dir.chdir test_directory do
      x = (multiglob_dirs + multiglob_files).sort
      r = Dir.multiglob_r('*').sort
      r.assert == x
    end
  end

end


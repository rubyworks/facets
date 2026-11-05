covers 'facets/fileutils/ln_r'

require 'tmpdir'

test_case FileUtils do

  class_method :ln_r do

    test "hard links a directory tree" do
      Dir.mktmpdir do |dir|
        Dir.mkdir("#{dir}/src")
        Dir.mkdir("#{dir}/src/sub")
        File.write("#{dir}/src/sub/a.txt", "a")
        FileUtils.ln_r("#{dir}/src", "#{dir}/dest")
        File.stat("#{dir}/dest/sub/a.txt").ino.assert == File.stat("#{dir}/src/sub/a.txt").ino
      end
    end

    test "noop makes no links" do
      Dir.mktmpdir do |dir|
        Dir.mkdir("#{dir}/src")
        FileUtils.ln_r("#{dir}/src", "#{dir}/dest", noop: true)
        File.refute.exist?("#{dir}/dest")
      end
    end

    test "leaves Ruby's own FileUtils.cp_lr working" do
      Dir.mktmpdir do |dir|
        Dir.mkdir("#{dir}/src")
        File.write("#{dir}/src/a.txt", "a")
        FileUtils.cp_lr("#{dir}/src", "#{dir}/copy")
        File.stat("#{dir}/copy/a.txt").ino.assert == File.stat("#{dir}/src/a.txt").ino
        FileUtils.ln_r("#{dir}/src", "#{dir}/dest")
      end
    end

  end

end

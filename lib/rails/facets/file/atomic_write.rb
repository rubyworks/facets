# This is a precursor to the possibility of a more extensive Atomic File I/O
# system. For now it simply provides a means for atomic file writing.

require 'thread'    unless defined?(Thread)
require 'tempfile'  unless defined?(Tempfile)
require 'fileutils' unless defined?(FileUtils)

class File

  # Write to a file atomically. Useful for situations where you don't
  # want other processes or threads to see half-written files.
  #
  #   File.atomic_write("important.txt") do |file|
  #     file.write("hello")
  #   end
  #
  # If your temporary directory is not on the same filesystem as the file you're
  # trying to write, you can provide a different temporary directory.
  #
  #   File.atomic_write("important.txt", "tmp") do |file|
  #     file.write("hello")
  #   end
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: David Heinemeier Hansson
  #
  # @uncommon
  #   require 'facets/fileutils/atomic_write'
  #
  def self.atomic_write(file_name, temp_dir=nil)
    temp_dir  = temp_dir || Dir.tmpdir
    temp_file = Tempfile.new(basename(file_name), temp_dir)

    yield temp_file
    temp_file.close

    begin
      ## Get original file permissions
      old_stat = stat(file_name)
    rescue Errno::ENOENT
      ## No old permissions, write a temp file to determine the defaults
      check_name = join(dirname(file_name), ".permissions_check.#{Thread.current.object_id}.#{Process.pid}.#{rand(1000000)}")
      open(check_name, "w") { }
      old_stat = stat(check_name)
      unlink(check_name)
    end

    ## Overwrite original file with temp file
    FileUtils.mv(temp_file.path, file_name)

    ## Set correct permissions on new file
    chown(old_stat.uid, old_stat.gid, file_name)
    chmod(old_stat.mode, file_name)
  end

end

require 'tempfile' unless defined?(Tempfile)

require 'facets/file/atomic_id'

class File

  # Same as `File.open`, but acts on a temporary copy of named
  # file, copying the file back to the original on completion.
  #
  # @uncommon
  #   require 'facets/fileutils/atomic_open'
  #
  def self.atomic_open(file_name, mode="r", temp_dir=nil, &block)
    temp_dir  = temp_dir || Dir.tmpdir
    temp_file = Tempfile.new("#{atomic_id}-" + basename(file_name), temp_dir)

    if File.exist?(file_name)
      FileUtils.cp(file_name, temp_file)
    end

    open(temp_file, mode, &block)

    FileUtils.cp(temp_file, file_name)
  end

end

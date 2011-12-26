require 'facets/filetest/safe'
require 'facets/filetest/contains'
require 'facets/filetest/relative'

=begin
module FileTest

  # Return a cached list of the PATH environment variable.
  # This is a support method used by #bin?
  def command_paths
    @command_paths ||= ENV['PATH'].split(/[:;]/)
  end

  # Is a file a bin/ executable?
  #
  # TODO: Make more robust. Probably needs to be fixed for Windows.
  def bin?(fname)
    is_bin = command_paths.any? do |f|
      FileTest.exist?(File.join(f, fname))
    end
    #is_bin ? File.basename(fname) : false
    is_bin ? fname : false
  end

end
=end

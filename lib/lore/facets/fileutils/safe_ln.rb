require 'fileutils'

module FileUtils

  module_function

  LINKING_SUPPORTED = [true]

  # Attempt to do a normal file link, but fall back
  # to a copy if the link fails.
  #
  # CREDIT Jim Weirich

  def safe_ln(*args)
    unless LINKING_SUPPORTED[0]
      cp(*args)
    else
      begin
        ln(*args)
      rescue Errno::EOPNOTSUPP
        LINKING_SUPPORTED[0] = false
        cp(*args)
      end
    end
  end

end


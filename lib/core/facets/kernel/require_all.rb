module Kernel

  # Require a pattern of files. This make is easy
  # to require an entire directory, for instance...
  #
  #   require_all 'facets/time/*'
  #
  # You can also you #require_all relative to the
  # current script simply by using __DIR__...
  #
  #   require_all(__DIR__ + '/foo/*')
  #
  def require_all(pat)
    $LOAD_PATH.each do |path|
      fs = Dir[File.join(path,pat)]
      unless fs.empty?
        fs.each { |f|
          Kernel.require(f) unless File.directory?(f)
        }
        break;
      end
    end
  end

end


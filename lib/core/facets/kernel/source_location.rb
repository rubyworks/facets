module Kernel

  unless method_defined?(:source_location) # 1.9

    def source_location
      file, line, meth = *caller(1).first.split(':')
      return file, line
    end

  end

end


module Kernel

  unless private_method_defined?(:load_relative)  # Will Ruby ever support out-of-the-box?

    # Load file from same dir as calling script.
    #
    #   load_relative 'myscript'
    #
    # CREDIT: Paul Brannan, Pragmatic Programmers
    #
    def load_relative(relative_feature, safe=nil)
      c = caller.first
      fail "Can't parse #{c}" unless c.rindex(/:\d+(:in `.*')?$/)
      file = $` # File.dirname(c)
      if /\A\((.*)\)/ =~ file # eval, etc.
        raise LoadError, "require_relative is called in #{$1}"
      end
      absolute = File.expand_path(relative_feature, File.dirname(file))
      load absolute, safe
    end

  end

end


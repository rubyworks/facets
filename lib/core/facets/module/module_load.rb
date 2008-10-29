class Module

  #unless (RUBY_VERSION[0,3] == '1.9')

    # Load file into module/class namespace.
    #
    #   CREDIT: Trans

    def module_load( path )
      if path =~ /^[\/~.]/
        file = File.expand_path(path)
      else
        $LOAD_PATH.each do |lp|
          file = File.join(lp,path)
          break if File.exist?(file)
          file = nil
        end
      end
      raise LoadError, "no such file to load -- #{path}" unless file
      module_eval(File.read(file))
    end

    # Require file into module/class namespace.
    #
    #   CREDIT: Trans

    def module_require( path )
      if path =~ /^[\/~.]/
        file = File.expand_path(path)
      else
        $LOAD_PATH.each do |lp|
          file = File.join(lp,path)
          break if File.exist?(file)
          file += '.rb'
          break if File.exist?(file)
          file = nil
        end
      end
      raise LoadError, "no such file to load -- #{path}" unless file
      @loaded ||= {}
      if @loaded.key?(file)
        false
      else
        @loaded[file] = true
        script = File.read(file)
        module_eval(script)
        true
      end
    end

    alias_method :class_require, :module_require
    alias_method :class_load, :module_load

  #end

end

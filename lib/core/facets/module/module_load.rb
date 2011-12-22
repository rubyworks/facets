class Module

  # Load file directly into module/class namespace.
  #
  # Please use this with careful consideration.
  # It is best suited to loading plugin-type scripts,
  # and should generally not be used as a substitue for
  # Ruby's standard load system.
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: Trans
  #
  # @uncommon
  #   require 'facets/module/module_load'
  #
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
  # Unlike load this keeps a per-module cache and will
  # not load the same file into the same module more
  # than once despite repeated attempts.
  #
  # The cache is kept in a global var called +$module_require+.
  #
  # Please use this with careful consideration.
  # It is best suited to loading plugin-type scripts,
  # and should generally not be used as a substitue for
  # Ruby's standard load system.
  #
  # NOTE: This method is not a common core extension and is not loaded
  # automatically when using <code>require 'facets'</code>.
  #
  # CREDIT: Trans
  #
  # @uncommon
  #   require 'facets/module/module_load'
  #
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
    # per-module load cache
    $module_require ||= {}
    $module_require[self] ||= {}
    loaded = $module_require[self]
    if loaded.key?(file)
      false
    else
      loaded[file] = true
      script = File.read(file)
      module_eval(script)
      true
    end
  end

  alias_method :class_require, :module_require
  alias_method :class_load, :module_load
end


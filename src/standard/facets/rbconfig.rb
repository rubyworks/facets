# An extended rendition of the Ruby's standard RbConfig module.
module RbConfig

  #
  def self.inspect
    CONFIG.inspect
  end

  # Methodized lookup of config.
  def self.method_missing(s,*a,&b)
    s = s.to_s
    if CONFIG.key?(s)
      CONFIG[s]
    elsif CONFIG.key?(s.upcase)
      CONFIG[s.upcase]
    else
      super(s,*a,&b)
    end
  end

  # TODO: parse configure_args into methods too?

  # In case rubygems has already defined it.
  unless method_defined?(:datadir)
    # Return the path to the data directory associated with the
    # given library/package name. Normally this is just
    #
    #   "#{Config::CONFIG['datadir']}/#{name}"
    #
    # but may be modified by tools like RubyGems to handle
    # versioned data directories.
    def self.datadir(package_name)
      File.join(CONFIG['datadir'], package_name)
    end
  end

  #
  def self.host_os
    CONFIG['host_os']
  end

  def linux?
    host_os =~ /linux|cygwin/
  end

  def mac?
    host_os =~ /mac|darwin/
  end

  def bsd?
    host_os =~ /bsd/
  end

  def windows?
    host_os =~ /mswin|mingw/
  end

  def solaris?
    host_os =~ /solaris|sunos/
  end

  # TODO: who knows what symbian returns?
  def symbian?
    host_os =~ /symbian/
  end

  #
  def posix?
    linux? or mac? or bsd? or solaris? or begin 
      fork do end
      true
    rescue NotImplementedError, NoMethodError
      false
    end
  end

end


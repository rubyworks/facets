require 'facets/platform'

# An extended rendition of the Ruby's standard Config module.
module Config

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

  # Determine byte order of underlying machine.
  # Examines the byte order of the underlying machine.
  # Returns <code>:big</code> if Big Endian and
  # <code>:little</code> if Little Endian.
  def self.byte_order
    if [0x12345678].pack("L") == "\x12\x34\x56\x78"
      :big
    else
      :little
    end
  end

  def self.byteorder
    byte_order
  end

  #
  def self.little_endian?
    byte_order == :little
  end

  #
  def self.big_endian?
    byte_order == :big
  end

  #
  def self.platform
    Platform.local
  end

  #
  def self.cpu
    platform.cpu
  end

  #
  def self.os
    platform.os
  end

  #
  def self.java?
    !(/java/.match(RUBY_PLATFORM).nil?)
  end

  #
  def self.jruby?
    !! /jruby/.match(arch)
  end

  #
  def self.windows?
    !! /mswin/.match(arch)
  end

  #
  def self.linux?
    !! /linux/.match(arch)
  end

=begin
  # platform
  def current_platform
    arch = Config::CONFIG['arch']
    #cpu, os = arch.split '-', 2
    return match_platform(arch)
  end

  #
  def match_platform(arch)
    cpu, os = arch.split '-', 2
    cpu, os = nil, cpu if os.nil? # java

    cpu = case cpu
          when /i\d86/ then 'x86'
          else cpu
          end

    os  = case os
          when /cygwin/ then            [ 'cygwin',  nil ]
          when /darwin(\d+)?/ then      [ 'darwin',  $1  ]
          when /freebsd(\d+)/ then      [ 'freebsd', $1  ]
          when /^java$/ then            [ 'java',    nil ]
          when /^java([\d.]*)/ then     [ 'java',    $1  ]
          when /linux/ then             [ 'linux',   $1  ]
          when /mingw32/ then           [ 'mingw32', nil ]
          when /mswin32/ then           [ 'mswin32', nil ]
          when /openbsd(\d+\.\d+)/ then [ 'openbsd', $1  ]
          when /solaris(\d+\.\d+)/ then [ 'solaris', $1  ]
          else                          [ 'unknown', nil ]
          end

    [cpu, os].flatten.compact.join("-")
  end
=end

end

# Current CPU's Byte Order
BYTE_ORDER = Config.byte_order

# Current CPU
CPU = Config.platform.cpu

# Current Operating System
OS  = Config.platform.os

# Current Operating System Version
OS_VERSION = Config.platform.version


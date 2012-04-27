module ::Kernel
  class << self
    alias_method :require_without_monitor, :require
    alias_method :load_without_monitor, :load
  end

  alias_method :require_without_monitor, :require
  alias_method :load_without_monitor, :load

  # Require script and print what is being require.
  def require(file)
    $stderr.puts "monitor require: #{file}\n#{caller.inspect}\n\n"
    require_without_monitor(file)
  end

  module_function :require

  # Load script and print what is being loaded.
  def load(file, wrap=false)
    $stderr.puts "monitor load: #{file}\n#{caller.inspect}\n\n"
    load_without_monitor(file, wrap)
  end

  module_function :load
end


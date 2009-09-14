# = Plugin Manger
#
# Find plugins easily.
#
# NOTE: This is likely to be replaced with
# a more generic means of finding libraries.
#
module PluginManager
  extend self

  # Find plugins, searching through standard $LOAD_PATH,
  # Roll Libraries and RubyGems.
  #
  # +match+ is a file glob for finding plugins.
  #
  #   PluginManager.find('syckles/*')
  #
  def find(match)
    plugins = []
    # Standard $LOAD_PATH
    $LOAD_PATH.uniq.each do |path|
      list = Dir.glob(File.join(path, match))
      #dirs = dirs.select{ |d| File.directory?(d) }
      list = list.map{ |d| d.chomp('/') }
      plugins.concat(list)
    end
    # ROLL (load latest versions only)
    if defined?(::Roll)
      ::Roll::Library.ledger.each do |name, lib|
        lib = lib.sort.first if Array===lib
        lib.load_path.each do |path|
          find = File.join(lib.location, path, match)
          list = Dir.glob(find)
          list = list.map{ |d| d.chomp('/') }
          plugins.concat(list)
        end
      end
    end
    # RubyGems (load latest versions only)
    if defined?(::Gem)
      Gem.latest_load_paths do |path|
        list = Dir.glob(File.join(path, match))
        list = list.map{ |d| d.chomp('/') }
        plugins.concat(list)
      end
    end
    plugins
  end

end

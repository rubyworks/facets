require 'fileutils'

module FileUtils
  module_function

  # The opposite of #uptodate?
  def outofdate?(path, *sources)
    #return true unless File.exist?(path)
    ! uptodate?(path, sources.flatten)
  end

  # Alias for #outofdate?
  alias_method :out_of_date?, :outofdate?

  # Alias for #uptodate?
  alias_method :up_to_date?, :uptodate?

  # # TODO: Does a path need updating, based on given +sources+?
  # # This compares mtimes of give paths. Returns false
  # # if the path needs to be updated.
  # #
  # # DEPRECATE: Is this in any way better than `! uptodate?` ?
  # def out_of_date?(path, *sources)
  #   return true unless File.exist?(path)
  # 
  #   sources = sources.collect{ |source| Dir.glob(source) }.flatten
  #   mtimes  = sources.collect{ |file| File.mtime(file) }
  # 
  #   return true if mtimes.empty?  # TODO: This the way to go here?
  # 
  #   File.mtime(path) < mtimes.max
  # end

  # Make public (for all submodules too).
  public :outofdate?
  public :out_of_date?
  public :up_to_date?
end

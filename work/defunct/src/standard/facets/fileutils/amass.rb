module FileUtils

  module_function

  # An intergrated glob like method that take a set of include globs,
  # exclude globs and ignore globs to produce a collection of paths.
  # 
  # The ignore_globs differ from exclude_globs in that they match by
  # the basename of the path rather than the whole pathname.
  #
  # TODO: Should ignore be based on any portion of the path, not just the basename?
  #
  def amass(include_globs, exclude_globs=[], ignore=[])
    include_files = include_globs.flatten.map{ |g| Dir.glob(g) }.flatten.uniq
    exclude_files = exclude_globs.flatten.map{ |g| Dir.glob(g) }.flatten.uniq

    include_globs = include_globs.map{ |f| File.directory?(f) ? File.join(f, '**/*') : f } # Recursive!
    exclude_globs = exclude_globs.map{ |f| File.directory?(f) ? File.join(f, '**/*') : f } # Recursive!

    include_files = include_globs.flatten.map{ |g| Dir.glob(g) }.flatten.uniq
    exclude_files = exclude_globs.flatten.map{ |g| Dir.glob(g) }.flatten.uniq

    files = include_files - exclude_files

    files = files.reject{ |f| ignore.any?{ |x| File.fnmatch?(x, File.basename(f)) } }

    files
  end

  # Make public (for all submodules too).
  public :amass

end

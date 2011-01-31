class Dir

  # Like +glob+ but can take multiple patterns.
  #
  #   Dir.multiglob('tmp/*.rb', 'tmp/*.py')
  #
  # Rather then constants for options multiglob accepts a trailing options
  # hash of symbol keys...
  #
  #   :noescape    File::FNM_NOESCAPE
  #   :casefold    File::FNM_CASEFOLD
  #   :pathname    File::FNM_PATHNAME
  #   :dotmatch    File::FNM_DOTMATCH
  #   :strict      File::FNM_PATHNAME && File::FNM_DOTMATCH
  #
  # It also has an option for recurse...
  #
  #   :recurse     Recurively include contents of directories.
  #
  # For example
  #
  #   Dir.multiglob('tmp/*', :recurse => true)
  #
  # would have the same result as
  #
  #   Dir.multiglob('tmp/**/*')
  #
  def self.multiglob(*patterns)
    options  = (Hash === patterns.last ? patterns.pop : {})

    if options.delete(:recurse)
      ##patterns += patterns.collect{ |f| File.join(f, '**', '**') }
      multiglob_r(*patterns)
    end

    bitflags = 0
    bitflags |= File::FNM_NOESCAPE if options[:noescape]
    bitflags |= File::FNM_CASEFOLD if options[:casefold]
    bitflags |= File::FNM_PATHNAME if options[:pathname] or options[:strict]
    bitflags |= File::FNM_DOTMATCH if options[:dotmatch] or options[:strict]

    patterns = [patterns].flatten.compact

    if options[:recurse]
      patterns += patterns.collect{ |f| File.join(f, '**', '**') }
    end

    files = []
    files += patterns.collect{ |pattern| Dir.glob(pattern, bitflags) }.flatten.uniq

    return files
  end

  # The same as +multiglob+, but recusively includes directories.
  #
  #   Dir.multiglob_r('tmp')
  #
  # is equivalent to
  #
  #   Dir.multiglob('tmp', :recurse=>true)
  #
  # The effect of which is
  #
  #   Dir.multiglob('tmp', 'tmp/**/**')
  #
  def self.multiglob_r(*patterns)
    options = Hash === patterns.last ? patterns.pop : {}
    matches = multiglob(*patterns)
    directories = matches.select{ |m| File.directory?(m) }
    matches += directories.map{ |d| multiglob_r(File.join(d, '**'), options) }.flatten
    matches.uniq
    ##options = (Hash === patterns.last ? patterns.pop : {})
    ##options[:recurse] = true
    ##patterns << options
    ##multiglob(*patterns)
  end

end

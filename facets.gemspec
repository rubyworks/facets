# encoding: utf-8

require 'yaml'
require 'pathname'

module Indexer

  # Convert index data into a gemspec.
  #
  # Notes:
  #   * Assumes all executables are in bin/.
  #   * Does not yet handle default_executable setting.
  #   * Does not yet handle platform setting.
  #   * Does not yet handle required_ruby_version.
  #   * Support for rdoc entries is weak.
  #
  class GemspecExporter

    # File globs to include in package --unless a manifest file exists.
    FILES = ".index .yardopts alt bin data demo ext features lib man spec test try* [A-Z]*.*" unless defined?(FILES)

    # File globs to omit from FILES.
    OMIT = "Config.rb" unless defined?(OMIT)

    # Standard file patterns.
    PATTERNS = {
      :root => '{.index,Gemfile}',
      :bin  => 'bin/*',
      :lib  => 'lib/{**/}*', #.rb',
      :ext  => 'ext/{**/}extconf.rb',
      :doc  => '*.{txt,rdoc,md,markdown,tt,textile}',
      :test => '{test,spec}/{**/}*.rb'
    } unless defined?(PATTERNS)

    # For which revision of indexer spec is this converter intended?
    REVISION = 2013 unless defined?(REVISION)

    #
    def self.gemspec
      new.to_gemspec
    end

    #
    attr :metadata

    #
    def initialize(metadata=nil)
      @root_check = false

      if metadata
        root_dir = metadata.delete(:root)
        if root_dir
          @root = root_dir
          @root_check = true
        end
        metadata = nil if metadata.empty?
      end

      @metadata = metadata || YAML.load_file(root + '.index')

      if @metadata['revision'].to_i != REVISION
        warn "This gemspec exporter was not designed for this revision of index metadata."
      end
    end

    #
    def has_root?
      root ? true : false
    end

    #
    def root
      return @root if @root || @root_check
      @root_check = true
      @root = find_root
    end

    #
    def manifest
      return nil unless root
      @manifest ||= Dir.glob(root + 'manifest{,.txt}', File::FNM_CASEFOLD).first
    end

    #
    def scm
      return nil unless root
      @scm ||= %w{git hg}.find{ |m| (root + ".#{m}").directory? }.to_sym
    end

    #
    def files
      return [] unless root
      @files ||= \
        if manifest
          File.readlines(manifest).
            map{ |line| line.strip }.
            reject{ |line| line.empty? || line[0,1] == '#' }
        else
          list = []
          Dir.chdir(root) do
            FILES.split(/\s+/).each do |pattern|
              list.concat(glob(pattern))
            end
            OMIT.split(/\s+/).each do |pattern|
              list = list - glob(pattern)
            end
          end
          list
        end.select{ |path| File.file?(path) }.uniq
    end

    #
    def glob_files(pattern)
      return [] unless root
      Dir.chdir(root) do
        Dir.glob(pattern).select do |path|
          File.file?(path) && files.include?(path)
        end
      end
    end

    def patterns
      PATTERNS
    end

    def executables
      @executables ||= \
        glob_files(patterns[:bin]).map do |path|
          File.basename(path)
        end
    end

    def extensions
      @extensions ||= \
        glob_files(patterns[:ext]).map do |path|
          File.basename(path)
        end
    end

    def name
      metadata['name'] || metadata['title'].downcase.gsub(/\W+/,'_')
    end

    def homepage
      page = (
        metadata['resources'].find{ |r| r['type'] =~ /^home/i } ||
        metadata['resources'].find{ |r| r['name'] =~ /^home/i } ||
        metadata['resources'].find{ |r| r['name'] =~ /^web/i }
      )
      page ? page['uri'] : false
    end

    def licenses
      metadata['copyrights'].map{ |c| c['license'] }.compact
    end

    def require_paths
      paths = metadata['paths'] || {}
      paths['load'] || ['lib']
    end

    #
    # Convert to gemnspec.
    #
    def to_gemspec
      if has_root?
        Gem::Specification.new do |gemspec|
          to_gemspec_data(gemspec)
          to_gemspec_paths(gemspec)
        end
      else
        Gem::Specification.new do |gemspec|
          to_gemspec_data(gemspec)
          to_gemspec_paths(gemspec)
        end
      end
    end

    #
    # Convert pure data settings.
    #
    def to_gemspec_data(gemspec)
      gemspec.name        = name
      gemspec.version     = metadata['version']
      gemspec.summary     = metadata['summary']
      gemspec.description = metadata['description']

      metadata['authors'].each do |author|
        gemspec.authors << author['name']

        if author.has_key?('email')
          if gemspec.email
            gemspec.email << author['email']
          else
            gemspec.email = [author['email']]
          end
        end
      end

      gemspec.licenses = licenses

      requirements = metadata['requirements'] || []
      requirements.each do |req|
        next if req['optional']
        next if req['external']

        name    = req['name']
        groups  = req['groups'] || []

        version = gemify_version(req['version'])

        if groups.empty? or groups.include?('runtime')
          # populate runtime dependencies  
          if gemspec.respond_to?(:add_runtime_dependency)
            gemspec.add_runtime_dependency(name,*version)
          else
            gemspec.add_dependency(name,*version)
          end
        else
          # populate development dependencies
          if gemspec.respond_to?(:add_development_dependency)
            gemspec.add_development_dependency(name,*version)
          else
            gemspec.add_dependency(name,*version)
          end
        end
      end

      # convert external dependencies into gemspec requirements
      requirements.each do |req|
        next unless req['external']
        gemspec.requirements << ("%s-%s" % req.values_at('name', 'version'))
      end

      gemspec.homepage = homepage
      gemspec.require_paths = require_paths
      gemspec.post_install_message = metadata['install_message']
    end

    #
    # Set gemspec settings that require a root directory path.
    #
    def to_gemspec_paths(gemspec)
      gemspec.files       = files
      gemspec.extensions  = extensions
      gemspec.executables = executables

      if Gem::VERSION < '1.7.'
        gemspec.default_executable = gemspec.executables.first
      end

      gemspec.test_files = glob_files(patterns[:test])

      unless gemspec.files.include?('.document')
        gemspec.extra_rdoc_files = glob_files(patterns[:doc])
      end
    end

    #
    # Return a copy of this file. This is used to generate a local
    # .gemspec file that can automatically read the index file.
    #
    def self.source_code
      File.read(__FILE__)
    end

  private

    def find_root
      root_files = patterns[:root]
      if Dir.glob(root_files).first
        Pathname.new(Dir.pwd)
      elsif Dir.glob("../#{root_files}").first
        Pathname.new(Dir.pwd).parent
      else
        #raise "Can't find root of project containing `#{root_files}'."
        warn "Can't find root of project containing `#{root_files}'."
        nil
      end
    end

    def glob(pattern)
      if File.directory?(pattern)
        Dir.glob(File.join(pattern, '**', '*'))
      else
        Dir.glob(pattern)
      end
    end

    def gemify_version(version)
      case version
      when /^(.*?)\+$/
        ">= #{$1}"
      when /^(.*?)\-$/
        "< #{$1}"
      when /^(.*?)\~$/
        "~> #{$1}"
      else
        version
      end
    end

  end

end

Indexer::GemspecExporter.gemspec
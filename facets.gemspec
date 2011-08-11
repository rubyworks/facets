# encoding: utf-8

require 'yaml'

Gem::Specification.new do |gemspec|

  manifest = Dir.glob('manifest{,.txt)', File::FNM_CASEFOLD).first

  scm = case
        when File.directory?('.git')
          :git
        end

  files = case
          when manifest
           File.readlines(manifest).
             map{ |line| line.srtip }.
             reject{ |line| line.empty? || line[0,1] == '#' }
          when scm == :git
           `git ls-files -z`.split("\0")
          else
            Dir.glob('{**/}{.*,*}')  # TODO: be more specific using standard locations ?
          end.select{ |path| File.file?(path) }

  patterns = {
    :bin_files  => 'bin/*',
    :lib_files  => 'lib/{**/}*.rb',
    :ext_files  => 'ext/{**/}extconf.rb',
    :doc_files  => '*.{txt,rdoc,md,markdown,tt,textile}',
    :test_files => '{test/{**/}*_test.rb,spec/{**/}*_spec.rb}'
  }

  glob_files = lambda { |pattern|
    Dir.glob(pattern).select { |path|
      File.file?(path) && files.include?(path)
    }
  }

  #files = glob_files[patterns[:files]]

  executables = glob_files[patterns[:bin_files]].map do |path|
                  File.basename(path)
                end

  extensions = glob_files[patterns[:ext_files]].map do |path|
                 File.basename(path)
               end

  metadata = YAML.load_file('.ruby')

  # build-out the gemspec

  case metadata['revision']
  when 0
    gemspec.name        = metadata['name']
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

    gemspec.licenses = metadata['licenses']

    metadata['requirements'].each do |req|
      name    = req['name']
      version = req['version']
      groups  = req['groups'] || []

      if md = /^(.*?)([+-~])$/.match(version)
        version = case md[2]
                    when '+' then ">= #{$1}"
                    when '-' then "< #{$1}"
                    when '~' then "~> #{$1}"
                    else version
                  end
      end

      #development = req['development']
      #if development
      #  # populate development dependencies
      #  if gemspec.respond_to?(:add_development_dependency)
      #    gemspec.add_development_dependency(name,*version)
      #  else
      #    gemspec.add_dependency(name,*version)
      #  end
      #else
      #  # populate runtime dependencies  
      #  if gemspec.respond_to?(:add_runtime_dependency)
      #    gemspec.add_runtime_dependency(name,*version)
      #  else
      #    gemspec.add_dependency(name,*version)
      #  end
      #end

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

    # convert external dependencies into a requirements
    if metadata['external_dependencies']
      ##gemspec.requirements = [] unless metadata['external_dependencies'].empty?
      metadata['external_dependencies'].each do |req|
        gemspec.requirements << req.to_s
      end
    end

    # determine homepage from resources
    homepage = metadata['resources'].find{ |key, url| key =~ /^home/ }
    gemspec.homepage = homepage.last if homepage

    gemspec.require_paths        = metadata['load_path'] || ['lib']
    gemspec.post_install_message = metadata['install_message']

    # RubyGems specific metadata
    gemspec.files       = files
    gemspec.extensions  = extensions
    gemspec.executables = executables

    if Gem::VERSION < '1.7.'
      gemspec.default_executable = gemspec.executables.first
    end

    gemspec.test_files = glob_files[patterns[:test_files]]

    unless gemspec.files.include?('.document')
      gemspec.extra_rdoc_files = glob_files[patterns[:doc_files]]
    end
  end
end

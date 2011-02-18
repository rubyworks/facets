require 'fileutils'

module FileUtils
  module_function

  # Stage by hard linking included files to a stage directory.
  #
  # stage_directory   -  Where to stage the files
  # source_directory  -  Where to find files to stage
  # files             -  Files to link in stage relative to source
  #
  # TODO: Rename to #link_stage or something less likely to name clash?
  # TODO: Add options for :verbose, :noop and :dryrun ?
  #
  def stage(stage_directory, source_directory, files, options={})
    return stage_directory if options[:noop] || options[:dryrun]

    stage_directory, source_directory = stage_directory.to_s, source_directory.to_s
    ## ensure existance of staging area
    rm_r(stage_directory) if File.directory?(stage_directory)
    mkdir_p(stage_directory)
    ## link files into staging area
    files.each do |f|
      src  = File.join(source_directory, f)
      file = File.join(stage_directory, f)
      if File.directory?(src)
        mkdir_p(file) unless File.exist?(file)
      else
        fdir = File.dirname(file)
        mkdir_p(fdir) unless File.exist?(fdir)
        unless File.exist?(file) and File.mtime(file) >= File.mtime(src)
          ln(src, file) #safe_ln ?
        end
      end
    end
    return stage_directory
  end

  # Make public (for all submodules too).
  public :stage

  module NoWrite
    module_function
    def stage(stage_directory, files, options={})
      options[:noop] = true
      FileUtils.stage(stage_directory, files, options={})
    end
  end

  module Verbose
    module_function
    def stage(stage_directory, files, options={})
      options[:verbose] = true
      FileUtils.stage(stage_directory, files, options={})
    end
  end

  module DryRun
    module_function
    def stage(stage_directory, files, options={})
      options[:dryrun] = true
      FileUtils.stage(stage_directory, files, options={})
    end
  end

end

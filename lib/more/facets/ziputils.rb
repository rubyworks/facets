#require 'zlib'
#require 'facets/minitar'

# = ZipUtils
#
# Function module for compression methods.
#
# TODO: Much of this shells out. It would be best to internalize.
#
module ZipUtils

  COMPRESS_FORMAT = {
    '.tar.gz'  => 'tar_gzip',
    '.tgz'     => 'tar_gzip',
    '.tar.bz2' => 'tar_bzip2',
    '.zip'     => 'zip'
  }

  ###############
  module_function
  ###############

  # Compress folder or file based on given extension.
  # Supported extensions are:
  # * .tar.gz
  # * .tgz
  # * .tar.bz2
  # * .zip
  #
  # TODO: support gzip and bzip2 as well.
  def compress(folder, file, options={})
    format = COMPRESS_FORMAT[File.extname(file)]
    if format
      send(format, folder, file, options)
    else
      raise ArgumentError, "unknown compression format -- #{format_extension}"
    end
  end

  #
  #
  def gzip(file, option={})
    require 'zlib'
    fname = File.basename(file) + '.gz'
    if options[:dryrun] or options[:verbose]
      puts "gzip #{file}"
    end
    Zlib::GzipWriter.open(fname) do |gz|
      gz.write(File.read(file))
    end unless options[:dryrun] or options[:noop]
    return File.expand_path(fname)
  end

  #
  #
  def ungzip(file, options={})
    require 'zlib'
    fname = File.basename(file).chomp(File.extname(file))
    if options[:dryrun] or options[:verbose]
      puts "ungzip #{file}"
    end
    Zlib::GzipReader.open(file) do |gz|
      File.open(fname, 'wb'){ |f| f << gz.read }
    end unless options[:dryrun] or options[:noop]
    return File.expand_path(fname)
  end

  #
  #
  def bzip2(file, option={})
    cmd = "bzip2 #{file}"
    puts   cmd if     options[:dryrun] or options[:verbose]
    system cmd unless options[:dryrun] or options[:noop]
    return File.expand_path(file + '.bz2')
  end

  alias_method :bzip, :bzip2

  #
  #
  def unbzip2(file, options={})
    cmd = "unbzip2 #{file}"
    puts   cmd if     options[:dryrun] or options[:verbose]
    system cmd unless options[:dryrun] or options[:noop]
    return File.expand_path(file.chomp(File.extname(file)))
  end

  alias_method :unbzip, :unbzip2

  #
  #
  def tar(folder, file=nil, options={})
    require 'facets/minitar'
    file ||= File.basename(File.expand_path(folder)) + '.tar'
    cmd = "tar -cf #{file} #{folder}"
    puts cmd if options[:verbose] or options[:dryrun]
    unless options[:noop] or options[:dryrun]
      gzIO = File.open(file, 'wb')
      Archive::Tar::Minitar.pack(folder, gzIO)
    end
    return File.expand_path(file)
  end

  #
  #
  def untar(file, options={})
    require 'facets/minitar'
    #file ||= File.basename(File.expand_path(folder)) + '.tar'
    cmd = "untar #{file}"
    puts cmd if options[:verbose] or options[:dryrun]
    unless options[:noop] or options[:dryrun]
      gzIO = File.open(file, 'wb')
      Archive::Tar::Minitar.unpack(gzIO)
    end
    return File.expand_path(file)
  end

  # Tar Gzip
  #
  def tar_gzip(folder, file=nil, options={})
    require 'zlib'
    require 'facets/minitar'
    file ||= File.basename(File.expand_path(folder)) + '.tar.gz' # '.tgz' which ?
    cmd = "tar --gzip -czf #{file} #{folder}"
    puts cmd if options[:verbose] or options[:dryrun]
    unless options[:noop] or options[:dryrun]
      gzIO = Zlib::GzipWriter.new(File.open(file, 'wb'))
      Archive::Tar::Minitar.pack(folder, gzIO)
    end
    return File.expand_path(file)
  end

  alias_method :tar_z, :tar_gzip

  #def tgz(folder, file=nil, options={})
  #  file ||= File.basename(File.expand_path(folder)) + '.tgz'
  #  tar_gzip(folder, file, options)
  #end

  # Untar Gzip
  #
  # TODO: Write unified untar_gzip function.
  def untar_gzip(file, options={})
    untar(ungzip(file, options), options)
  end

  alias_method :untar_z, :untar_gzip

  # Tar Bzip2
  #
  def tar_bzip2(folder, file=nil, options={})
    # name of file to create
    file ||= File.basename(File.expand_path(folder)) + '.tar.bz2'
    cmd = "tar --bzip2 -cf #{file} #{folder}"
    puts   cmd if     options[:dryrun] or options[:verbose]
    system cmd unless options[:dryrun] or options[:noop]
    return File.expand_path(file)
  end

  alias_method :tar_bzip, :tar_bzip2

  alias_method :tar_j, :tar_bzip2

  # Untar Bzip2
  #
  def untar_bzip2(file, options={})
    cmd = "tar --bzip2 -xf #{file}"
    puts   cmd if     options[:dryrun] or options[:verbose]
    system cmd unless options[:dryrun] or options[:noop]
  end

  alias_method :untar_bzip, :untar_bzip2

  alias_method :untar_j, :untar_bzip2

  # Zip
  #
  def zip(folder, file=nil, options={})
    raise ArgumentError if folder == '.*'
    file ||= File.basename(File.expand_path(folder)) + '.zip'
    cmd = "zip -rqu #{file} #{folder}"
    puts   cmd if     options[:dryrun] or options[:verbose]
    system cmd unless options[:dryrun] or options[:noop]
    return File.expand_path(file)
  end

  # Unzip
  #
  def unzip(file, options={})
    cmd = "unzip #{file}"
    puts   cmd if     options[:dryrun] or options[:verbose]
    system cmd unless options[:dryrun] or options[:noop]
  end

end #module ZipUtils

# Verbose version of ZipUtils.
#
# This is the same as passing :verbose flag to ZipUtils methods.

module ZipUtils::Verbose
  module_function

  def compress(format_extension, folder, file=nil, options={})
    options[:verbose] = true
    ZipUtils.tar_gzip(format_extension, folder, file, options)
  end

  def gzip(file, options={})
    options[:verbose] = true
    ZipUtils.gzip(file, options)
  end

  def ungzip(file, options={})
    options[:verbose] = true
    ZipUtils.ungzip(file, options)
  end

  def bzip2(file, options={})
    options[:verbose] = true
    ZipUtils.bzip2(file, options)
  end

  alias_method :bzip, :bzip2

  def unbzip2(file, options={})
    options[:verbose] = true
    ZipUtils.unbzip2(file, options)
  end

  alias_method :unbzip, :unbzip2

  def tar(folder, file=nil, options={})
    options[:verbose] = true
    ZipUtils.tar(folder, file, options)
  end

  def untar(file, options={})
    options[:verbose] = true
    ZipUtils.untar(file, options)
  end

  def tar_gzip(folder, file=nil, options={})
    options[:verbose] = true
    ZipUtils.tar_gzip(folder, file, options)
  end

  def untar_gzip(file, options={})
    options[:verbose] = true
    ZipUtils.untar_gzip(file, options)
  end

  def tar_bzip2(folder, file=nil, options={})
    options[:verbose] = true
    ZipUtils.untar_bzip2(folder, file, options)
  end

  def untar_bzip2(file, options={})
    options[:verbose] = true
    ZipUtils.untar_bzip2(file, options)
  end

  def zip(folder, file=nil, options={})
    options[:verbose] = true
    ZipUtils.unzip(folder, file, options)
  end

  def unzip(file, options={})
    options[:verbose] = true
    ZipUtils.unzip(file, options)
  end
end

# NoWrite Version of ZipUtils.
#
# This is the same as passing :noop flag to ZipUtils methods.

module ZipUtils::NoWrite
  module_function

  def compress(format_extension, folder, file=nil, options={})
    options[:noop] = true
    ZipUtils.tar_gzip(format_extension, folder, file, options)
  end

  def gzip(file, options={})
    options[:noop] = true
    ZipUtils.gzip(file, options)
  end

  def ungzip(file, options={})
    options[:noop] = true
    ZipUtils.ungzip(file, options)
  end

  def bzip2(file, options={})
    options[:noop] = true
    ZipUtils.bzip2(file, options)
  end

  alias_method :bzip, :bzip2

  def unbzip2(file, options={})
    options[:noop] = true
    ZipUtils.unbzip2(file, options)
  end

  alias_method :unbzip, :unbzip2

  def tar(folder, file=nil, options={})
    options[:noop] = true
    ZipUtils.tar(folder, file, options)
  end

  def untar(file, options={})
    options[:noop] = true
    ZipUtils.untar(file, options)
  end

  def tar_gzip(folder, file=nil, options={})
    options[:noop] = true
    ZipUtils.tar_gzip(folder, file, options)
  end

  def untar_gzip(file, options={})
    options[:noop] = true
    ZipUtils.untar_gzip(file, options)
  end

  def tar_bzip2(folder, file=nil, options={})
    options[:noop] = true
    ZipUtils.untar_bzip2(folder, file, options)
  end

  alias_method :tar_bzip, :tar_bzip2

  def untar_bzip2(file, options={})
    options[:noop] = true
    ZipUtils.untar_bzip2(file, options)
  end

  alias_method :untar_bzip, :untar_bzip2

  def zip(folder, file=nil, options={})
    options[:noop] = true
    ZipUtils.unzip(folder, file, options)
  end

  def unzip(file, options={})
    options[:noop] = true
    ZipUtils.unzip(file, options)
  end
end

# Dry-run verions of ZipUtils.
#
# This is the same as passing the :dryrun flag to ZipUtils.
# Which is also equivalent to passing :noop and :verbose together.

module ZipUtils::DryRun
  module_function

  def compress(format_extension, folder, file=nil, options={})
    options[:dryrun] = true
    ZipUtils.tar_gzip(format_extension, folder, file, options)
  end

  def gzip(file, options={})
    options[:dryrun] = true
    ZipUtils.gzip(file, options)
  end

  def ungzip(file, options={})
    options[:dryrun] = true
    ZipUtils.ungzip(file, options)
  end

  def bzip2(file, options={})
    options[:dryrun] = true
    ZipUtils.bzip2(file, options)
  end

  alias_method :bzip, :bzip2

  def unbzip2(file, options={})
    options[:dryrun] = true
    ZipUtils.unbzip2(file, options)
  end

  alias_method :unbzip, :unbzip2

  def tar(folder, file=nil, options={})
    options[:dryrun] = true
    ZipUtils.tar(folder, file, options)
  end

  def untar(file, options={})
    options[:dryrun] = true
    ZipUtils.untar(file, options)
  end

  def tar_gzip(folder, file=nil, options={})
    options[:dryrun] = true
    ZipUtils.tar_gzip(folder, file, options)
  end

  def untar_gzip(file, options={})
    options[:dryrun] = true
    ZipUtils.untar_gzip(file, options)
  end

  def tar_bzip2(folder, file=nil, options={})
    options[:dryrun] = true
    ZipUtils.untar_bzip2(folder, file, options)
  end

  alias_method :tar_bzip, :tar_bzip2

  def untar_bzip2(file, options={})
    options[:dryrun] = true
    ZipUtils.untar_bzip2(file, options)
  end

  alias_method :untar_bzip, :untar_bzip2

  def zip(folder, file=nil, options={})
    options[:dryrun] = true
    ZipUtils.unzip(folder, file, options)
  end

  def unzip(file, options={})
    options[:dryrun] = true
    ZipUtils.unzip(file, options)
  end
end



# OLD VERSION
#   #
#   # DryRun version of ZipUtils.
#   #
#
#   module DryRun
#     module_function
#
#     def compress( format, folder, to_file=nil )
#       send(FORMAT_TO_COMPRESS[format], folder, to_file)
#     end
#
#     # Tar Gzip
#
#     def tar_gzip( folder, to_file=nil )
#       to_file ||= File.basename(File.expand_path(folder)) + '.tar.gz'
#       puts "tar --gzip -czf #{to_file} #{folder}"
#     end
#
#     # Untar Gzip
#
#     def untar_gzip( file )
#       puts "tar --gzip -xzf #{file}"
#     end
#
#     # Tar Bzip2
#
#     def tar_bzip( folder, to_file=nil )
#       puts "tar --bzip2 -cf #{to_file} #{folder}"
#     end
#     alias_method :tar_bz2, :tar_bzip
#
#     # Untar Bzip2
#
#     def untar_bzip( file )
#       puts "tar --bzip2 -xf #{file}"
#     end
#     alias_method :untar_bz2, :untar_bzip
#
#     # Zip
#
#     def zip( folder, to_file=nil )
#       puts "zip -cf #{to_file} #{folder}"
#     end
#
#     # Unzip
#
#     def unzip( file )
#       puts "zip -xf #{file}"
#     end
#
#   end

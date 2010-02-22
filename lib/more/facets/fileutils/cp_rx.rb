module FileUtils

  # Both of these are modified from the implementations in fileutils.rb from Ruby 1.9.1p378.

  # Like FileUtils.cp_r, but takes a filter proc that can return false to skip a file.
  #
  #   cp_rx "bigDirectoryTree", "dest", {:noop => true} do |name|
	#     /dontCopyThis$/.match(name)
  #   end
  #
  # Note that if the filter rejects a subdirectory then everything within that
  # subdirectory is automatically skipped as well.

  def cp_rx(src, dest, options = {}, &filter)
	  fu_check_options(options, OPT_TABLE['cp_r'])
    if options[:verbose]
	    fu_output_message("cp -r#{options[:preserve] ? 'p' : ''}#{options[:remove_destination] ? ' --remove-destination' : ''} #{[src,dest].flatten.join ' '}")
    end
	  return if options[:noop]
	  fu_each_src_dest(src, dest) do |s, d|
		  copy_entryx(s, d, filter, options[:preserve], options[:dereference_root], options[:remove_destination])
	  end
  end

  # Like FileUtils.copy_entry, but takes a filter proc that can return false to skip a file.
  #
  # Note that if the filter rejects a subdirectory then everything within that
  # subdirectory is automatically skipped as well.

  def copy_entryx(src, dest, filter, preserve = false, dereference_root = false, remove_destination = false)
	  Entry_.new(src, nil, dereference_root).traverse do |ent|
		  if filter.call(ent.path) then
			  destent = Entry_.new(dest, ent.rel, false)
			  File.unlink destent.path if remove_destination && File.file?(destent.path)
			  ent.copy destent.path
			  ent.copy_metadata(destent.path) if preserve
		  end
	  end
  end

end


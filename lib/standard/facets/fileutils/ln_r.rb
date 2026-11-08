require 'fileutils'

module FileUtils

  unless respond_to?(:ln_r)

    #
    # Options: noop verbose dereference_root remove_destination
    #
    # Hard link +src+ to +dest+. If +src+ is a directory, this method links
    # all its contents recursively. If +dest+ is a directory, links
    # +src+ to +dest/src+.
    #
    # +src+ can be a list of files.
    #
    #   # Installing ruby library "mylib" under the site_ruby
    #   FileUtils.rm_r site_ruby + '/mylib', :force
    #   FileUtils.ln_r 'lib/', site_ruby + '/mylib'
    #
    #   # Examples of copying several files to target directory.
    #   FileUtils.ln_r %w(mail.rb field.rb debug/), site_ruby + '/tmail'
    #   FileUtils.ln_r Dir.glob('*.rb'), '/home/aamine/lib/ruby', :noop => true, :verbose => true
    #
    #   # If you want to copy all contents of a directory instead of the
    #   # directory itself, c.f. src/x -> dest/x, src/y -> dest/y,
    #   # use following code.
    #   FileUtils.ln_r 'src/.', 'dest'     # cp_r('src', 'dest') makes src/dest,
    #                                      # but this doesn't.
    #
    # It is much like Ruby's own FileUtils.cp_lr, and uses Ruby's
    # FileUtils.link_entry to make the links.
    #
    # TODO: Why --remove-destination and not just --force?
    def ln_r(src, dest, options = {})
      fu_output_message "ln -r#{options[:remove_destination] ? ' --remove-destination' : ''} #{[src,dest].flatten.join ' '}" if options[:verbose]
      return if options[:noop]
      options = options.dup
      options[:dereference_root] = true unless options.key?(:dereference_root)
      fu_each_src_dest(src, dest) do |s, d|
        link_entry s, d, options[:dereference_root], options[:remove_destination]
      end
    end
    module_function :ln_r

    OPT_TABLE['ln_r'] = [:noop, :verbose, :dereference_root, :remove_destination] if const_defined?(:OPT_TABLE) && !OPT_TABLE.frozen?

  end

end

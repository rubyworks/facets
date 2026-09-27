module Facets

  # Until 2027-09-30, `require 'facets'` still provides a few Rails-compatible
  # methods that now live in lib/rails. Each is defined here as a stub that
  # warns on first use, loads the real file (which replaces the stub), and
  # retries the call. Requiring the file directly skips the stub and the
  # warning. Methods that are already defined, e.g. by ActiveSupport, are
  # left alone.
  #
  #   Facets.rails_bridge(Hash, 'facets/hash/slice', :slice!)
  #
  def self.rails_bridge(owner, file, *names)
    names.each do |name|
      next if owner.method_defined?(name)
      owner.send(:define_method, name) do |*args, &block|
        warn "#{owner}##{name} will no longer be loaded by `require 'facets'` after 2027-09-30. " \
             "Add `require '#{file}'` to keep using it.", uplevel: 1
        require file
        if owner.instance_method(name).source_location&.first == __FILE__
          raise NoMethodError, "#{file} did not define #{owner}##{name}"
        end
        __send__(name, *args, &block)
      end
    end
  end

end

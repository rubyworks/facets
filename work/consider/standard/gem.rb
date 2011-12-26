
module Gem

  def self.active?(gemname)
    @loaded_specs ||= Hash.new
    @loaded_specs.key? gemname
  end

  def self.gemspec(gemname)
    @loaded_specs[gemname] if active?(gemname)
  end

  def self.gempath(gemname, subdir=nil)
    if active?(gemname)
      if subdir
        File.join( @loaded_specs[gemname].full_gem_path, subdir )
      else
        @loaded_specs[gemname].full_gem_path
      end
    end
  end

end

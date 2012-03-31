require 'facets/gem/specification/current_specs'

module Gem

  # Search RubyGems for matching paths in current gem versions.
  def self.search(match, options={})
    matches = []
    Gem::Specification.current_specs.each do |spec|
      glob = File.join(spec.lib_dirs_glob, match)
      list = Dir[glob] #.map{ |f| f.untaint }
      list = list.map{ |d| d.chomp('/') }
      matches.concat(list)
    end
    matches
  end

end


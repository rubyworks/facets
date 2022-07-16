module Facets
  #
  def self.index
    @index ||= (
      require 'yaml'
      YAML.load(File.new(File.dirname(__FILE__) + '/facets.yml'))
    )
  end

  #
  def self.const_missing(name)
    key = name.to_s.downcase
    index[key] || super(name)
  end

  # deprecate
  VERSION = '4.0.0'
end


module Facets
  #
  def self.profile
    @profile ||= (
      require 'yaml'
      YAML.load(File.new(File.dirname(__FILE__) + '/facets.yml'))
    )
  end

  #
  def self.const_missing(name)
    key = name.to_s.downcase
    profile[key] || super(name)
  end

  #
  VERSION = '2.9.3'  # profile['version']
end


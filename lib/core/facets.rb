dir = File.dirname(__FILE__) + '/facets/'
Dir.new(dir).each do |path|
  next unless File.extname(path) == '.rb'
  require('facets/' + path)  #require(dir + path)
end

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
  VERSION = profile['version']
end


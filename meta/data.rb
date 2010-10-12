Object.__send__(:remove_const, :VERSION) if Object.const_defined?(:VERSION)      # becuase Ruby 1.8~ gets in the way

module Facets

  def self.__DIR__
    File.dirname(__FILE__)
  end

  def self.package
    @package ||= (
      require 'yaml'
      YAML.load(File.new(__DIR__ + '/package'))
    )
  end

  def self.profile
    @profile ||= (
      require 'yaml'
      YAML.load(File.new(__DIR__ + '/profile'))
    )
  end

  def self.const_missing(name)
    key = name.to_s.downcase
    package[key] || profile[key] || super(name)
  end

end


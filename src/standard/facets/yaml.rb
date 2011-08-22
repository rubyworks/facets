require 'yaml'

module Kernel

  # The Kernel method #yaml is a shortcut to YAML::load.
  #
  #   data = yaml %{
  #     a: 1
  #     b: 2
  #   }  
  #   data #=> {"a"=>1, "b"=>2}
  #
  def yaml(*args,&blk)
    YAML.load(*args,&blk)
  end

  # As with #to_yaml but removes the header line (i.e. '---') to create
  # a "YAML fragment".
  #
  # CREDT: Thomas Sawyer
  def to_yamlfrag
    y = to_yaml
    y.sub!(/---\ */, '')
    y
  end
end

class File
  # File.yaml? provides a way to check if a file is a YAML
  # formatted file:
  #
  #   File.yaml?('project.yaml')  #=> true
  #   File.yaml?('project.xml')   #=> false
  #
  # Note this isn't perfect. At present it depends on the use
  # use of an initial document separator (eg. '---'). With
  # YAML 1.1 the %YAML delaration is supposed to be manditory,
  # so in the future this can be adapted to fit that standard.
  def self.yaml?(file)
    File.open(file) do |f|
      until f.eof?
        line = f.gets
        break true if line =~ /^---/
        break false unless line =~ /^(\s*#.*?|\s*)$/
      end
    end
  end
end

module YAML
  # Shortcut for:
  #
  #   YAML.load(File.new(file))
  #
  def self.read(file)
    load(File.new(file))
  end
end


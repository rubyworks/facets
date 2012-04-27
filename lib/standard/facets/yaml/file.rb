require 'yaml'

module YAML

  # Provides a simplistic way to check if a file is a YAML formatted
  # file:
  #
  #   YAML.file?('project.yaml')  #=> true
  #   YAML.file?('project.xml')   #=> false
  #
  # Note this isn't perfect. At present it depends on the use
  # use of an initial document separator (eg. '---'). With
  # YAML 1.1 the %YAML delaration is supposed to be manditory,
  # so in the future this can be adapted to fit that standard.

  def self.file?(file)
    File.open(file) do |f|
      until f.eof?
        line = f.gets
        break true if line =~ /^---/
        break false unless line =~ /^(\s*#.*?|\s*)$/
      end
    end
  end

end


class File

  # Same as `YAML.file?(file)`.
  #
  #   File.yaml?('project.yaml')  #=> true
  #   File.yaml?('project.xml')   #=> false
  #
  def self.yaml?(file)
    YAML.file?(file)
  end

end


# = YAML Extensions
#
# YAML related extenstions.
#
# The Kernel method #yaml is a shortcut to YAML::load.
#
#   yaml %{
#     a: 1
#     b: 2
#   }
#
# produes
#
#   {:a=>1, :b=>2}
#
# File.yaml? provides a way to check if a file is a YAML
# formatted file.
#
#   File.yaml?('project.yaml')  #=> true
#   File.yaml?('project.xml')   #=> false
#
# == Authors
#
# * Thomas Sawyer
#
# == Copyright
#
# Copyright (c) 2006 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'yaml'

module Kernel
  # Convenience method for loading YAML.
  #
  def yaml(*args,&blk)
    YAML.load(*args,&blk)
  end

  # As with #to_yaml but removes the header line (i.e. '---') to create a "YAML fragment".
  #
  def to_yamlfrag
    y = to_yaml
    y.sub!(/---\ */, '')
    y
  end
end

class File
  # Is a file a YAML file?
  #
  # Note this isn't perfect. At present it depends on the use
  # use of an initial document separator (eg. '---'). With
  # YAML 1.1 the %YAML delaration will be manditory, so in the
  # future this can be adapted to fit that standard.
  #
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


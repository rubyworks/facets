# = Shellwords Extended
#
# Adds extensions to Shellwords, namely #escape.
#
# == Authors
#
# * Thomas Sawuer
#
# == Copying
#
# Copyright (c) 2007 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'shellwords'

module Shellwords

  module_function

  # Escape special characters used in most
  # unix shells to use it, eg. with system().

  def escape(cmdline)
    cmdline.gsub(/([\\\t\| &`<>)('"])/) { |s| '\\' << s }
  end

end


class Array

  # Convert an array into command line parameters.
  # The array is accepted in the format of Ruby
  # method arguments --ie. [arg1, arg2, ..., hash]

  def to_shellwords
    flags = (Hash===last ? pop : {})
    flags = flags.to_shellwords
    flags + ' ' + self #join(" ")
  end

  def to_shell
    to_shellwords.join(' ')
  end

  # Original name.
  alias_method :to_console, :to_shell
end


class Hash

  # Convert an array into command line parameters.
  # The array is accepted in the format of Ruby
  # method arguments --ie. [arg1, arg2, ..., hash]

  def to_shellwords
    flags = collect do |f,v|
      m = f.to_s.size == 1 ? '-' : '--'
      case v
      when Array
        v.collect{ |e| "#{m}#{f}='#{e}'" }.join(' ')
      when true
        "#{m}#{f}"
      when false, nil
        ''
      else
        "#{m}#{f}='#{v}'"
      end
    end
    flags #.join(" ")
  end

  def to_shell
    to_shellwords.join(' ')
  end

  # Original name.
  alias_method :to_console, :to_shell
end


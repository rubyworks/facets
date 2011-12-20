# = Logger
#
# Extended variation of Ruby's standard Logger library.
#
#   log = Logger.new
#
#   log.setup_format do |severity, timestamp, progname, msg|
#     Logger::SIMPLE_FORMAT % [severity, msg]
#   end
#
# == Conventions
#
# When using debug level logger messages always append 'if $DBG'
# at the end. This hack is needed because Ruby does not support
# lazy evaluation (lisp macros).
#
# == Authors
#
# * George Moschovitis
# * TransLogarithim
#
# == Copying
#
# Copyright (c) 2005 George Moschovitis
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require "logger"
require "time"

# = Logger
#
# Extended variation of Ruby's standard Logger library.
# Mainly for compatibility purposes (with what?)
#
#   log = Logger.new
#
#   log.setup_format do |severity, timestamp, progname, msg|
#     Logger::SIMPLE_FORMAT % [severity, msg]
#   end
#
# When using debug level logger messages always append 'if $DBG'
# at the end. This hack is needed because Ruby does not support
# lazy evaluation (lisp macros).
#
# TODO: What's all this about then?

class Logger

  # Some available logging formats.
  SIMPLE_FORMAT = "%5s: %s\n"
  DETAILED_FORMAT = "%s %5s: %s\n"

  # Dictate the way in which this logger should format the
  # messages it displays. This method requires a block. The
  # block should return formatted strings given severity,
  # timestamp, msg, progname.
  #
  # === Example
  #
  # logger = Logger.new
  # logger.setup_format do |severity, timestamp, msg, progname|
  #   "#{progname}@#{timestamp} - #{severity}::#{msg}"
  # end

  def setup_format(&format_proc)
    raise "Formating block needed" unless format_proc
    @format_proc = format_proc
  end

  def format_procedure
    @format_proc
  end

private

  attr_accessor :format_proc

  alias_method :format_message_without_proc, :format_message # :nodoc:

  def format_message(*args) # :nodoc:
    @format_proc ? @format_proc.call(*args) : format_message_without_proc(*args)
  end

# NOTE: trace is deprecated b/c binding of caller is no longer possible.
=begin
public
  # Prints a trace message to DEBUGLOG (at debug level).
  # Useful for emitting the value of variables, etc.  Use
  # like this:
  #
  #   x = y = 5
  #   trace 'x'        # -> 'x = 5'
  #   trace 'x ** y'   # -> 'x ** y = 3125'
  #
  # If you have a more complicated value, like an array of
  # hashes, then you'll probably want to use an alternative
  # output format.  For instance:
  #
  #   trace 'value', :yaml
  #
  # Valid output format values (the _style_ parameter) are:
  #
  #   :p :inspect
  #   :pp                     (pretty-print, using 'pp' library)
  #   :s :to_s
  #   :y :yaml :to_yaml       (using the 'yaml' library')
  #
  # The default is <tt>:p</tt>.
  #
  # CREDITS:
  #
  # This code comes straight from the dev-utils Gem.
  # Author: Gavin Sinclair <gsinclair@soyabean.com.au>

  def trace(expr, style=:p)
    unless expr.respond_to? :to_str
      warn "trace: Can't evaluate the given value: #{caller.first}"
    else
      raise "FACETS: binding/or_caller is no longer possible"
      require "facets/core/binding/self/of_caller"

      Binding.of_caller do |b|
        value = b.eval(expr.to_str)
        formatter = TRACE_STYLES[style] || :inspect
        case formatter
        when :pp then require 'pp'
        when :y, :yaml, :to_yaml then require 'yaml'
        end
        value_s = value.send(formatter)
        message = "#{expr} = #{value_s}"
        lines = message.split(/\n/)
        indent = "   "
        debug(lines.shift)
        lines.each do |line|
          debug(indent + line)
        end
      end
    end
  end

  TRACE_STYLES = {}  # :nodoc:
  TRACE_STYLES.update(
    :pp => :pp_s, :s => :to_s, :p => :inspect,
    :y => :to_yaml, :yaml => :to_yaml,
    :inspect => :inspect, :to_yaml => :to_yaml
  )
=end

end


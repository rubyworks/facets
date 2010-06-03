# = Pathname
#
# Ruby's standard Pathname class with extensions.
#
# == Authors:
#
# * Daniel Burger
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2006 Thomas Sawyer, Daniel Burger
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'pathname'
require 'facets/file/rootname'

class Pathname

  # Alias #to_s to #to_str when #to_str is not defined.
  #
  alias_method(:to_str, :to_s) unless method_defined?(:to_str)

  # Alternate to Pathname#new.
  #
  #   Pathname['/usr/share']
  #
  def self.[](path)
    new(path)
  end

  # Active path separator.
  #
  #   p1 = Pathname.new('/')
  #   p2 = p1 / 'usr' / 'share'   #=> Pathname:/usr/share
  #
  def self./(path)
    new(path)
  end

  # Root constant for building paths from root directory onward.
  def self.root
    Pathname.new('/')
  end

  # Home constant for building paths from root directory onward.
  #
  # TODO: Pathname#home needs to be more robust.
  #
  def self.home
    Pathname.new('~')
  end

  # Work constant for building paths from root directory onward.
  #
  def self.work
    Pathname.new('.')
  end

  # Try to get this into standard Pathname class.
  alias_method :/, :+

  # CREDIT Daniel Burger

  # Platform dependent null device.
  #
  def self.null
    case RUBY_PLATFORM
    when /mswin/i
      'NUL'
    when /amiga/i
      'NIL:'
    when /openvms/i
      'NL:'
    else
      '/dev/null'
    end
  end

  #
  def rootname
    self.class.new(File.rootname(to_s))
  end

  #
  def split_root
    head, tail = *::File.split_root(to_s)
    [self.class.new(head), self.class.new(tail)]
  end

  # Glob pathnames.
  def glob(match, *opts)
    flags = glob_flags(opts)
    Dir.glob(::File.join(self.to_s, match), flags).collect{ |m| self.class.new(m) }
  end

  # Return the first glob match.
  #
  # DEPRECATE: While slightly faster then glob().first, not really worth it
  # unless this can be rewritten to shortcut on first match (using fnmatch?).
  # In wich case, is there a better name for this method?
  def glob_first(match, *opts)
    flags = glob_flags(opts)
    file = ::Dir.glob(::File.join(self.to_s, match), flags).first
    file ? self.class.new(file) : nil
  end

  # Return globbed matches with pathnames relative to the current pathname.
  def glob_relative(match, *opts)
    flags = glob_flags(opts)
    files = Dir.glob(::File.join(self.to_s, match), flags)
    files = files.map{ |f| f.sub(self.to_s.chomp('/') + '/', '') }
    files.collect{ |m| self.class.new(m) }
  end

  private

  def glob_flags(opts)
    flags = 0
    opts.each do |opt|
      case opt when Symbol, String
        flags += ::File.const_get("FNM_#{opt}".upcase)
      else
        flags += opt
      end
    end
    flags
  end

  public

  #
  def empty?
    Dir.glob(::File.join(to_s, '*')).empty?
  end

  #
  def uptodate?(*sources)
    ::FileUtils.uptodate?(to_s, sources.flatten)
  end

  #
  def outofdate?(*sources)
    ::FileUtils.outofdate?(to_s, sources.flatten)
  end

  # Recursively visit a directory located by its path, yielding each resource
  # as its full matching pathname object. If called on a file, yield the file.
  #
  # call-seq:
  #   visit => yield each file
  #   visit(all: true) => yield visited directories as well
  #   visit(hidden: true) => yield hidden files and directories as well
  #
  # Example use case:
  #
  #   # get rid of any file but *.haml within app/**/*
  #   Pathname.new("app").visit do |f|
  #     FileUtils.rm_f(f) unless f.to_s =~ /\.haml$/
  #     puts "!!! deleting #{f}"
  #   end 
  #
  # CREDIT: Jean-Denis Vauguet
  def visit(options = {:all => false, :hidden => false})
    if self.directory?
      children.each do |entry|
        next if entry.basename.to_s[0] == "." && !options[:hidden]
        yield(entry) unless entry.directory? && !options[:all]
        #entry.visit(:all => options[:all]) { |sub_entry| yield sub_entry } if entry.directory?
        entry.visit(:all => options[:all], :hidden => options[:hidden]) do |sub_entry|
          yield(sub_entry)
        end if entry.directory?
      end
    else
      yield self
    end
  end

#   # Already included in 1.8.4+ version of Ruby (except for inclusion flag)
#   if not instance_methods.include?(:ascend)
#
#     # Calls the _block_ for every successive parent directory of the
#     # directory path until the root (absolute path) or +.+ (relative path)
#     # is reached.
#     def ascend(inclusive=false,&block) # :yield:
#       cur_dir = self
#       yield( cur_dir.cleanpath ) if inclusive
#       until cur_dir.root? or cur_dir == Pathname.new(".")
#         cur_dir = cur_dir.parent
#         yield cur_dir
#       end
#     end
#
#   end
#
#   # Already included in 1.8.4+ version of Ruby
#   if ! instance_methods.include?(:descend)
#
#     # Calls the _block_ for every successive subdirectory of the
#     # directory path from the root (absolute path) until +.+
#     # (relative path) is reached.
#     def descend()
#       @path.scan(%r{[^/]*/?})[0...-1].inject('') do |path, dir|
#         yield Pathname.new(path << dir)
#       path
#       end
#     end
#
#   end

  # Does a directory contain a matching entry?
  # Or if the pathname is a file, same as #fnmatch.
  def include?(pattern,*opts)
    if directory?
      glob_first(pattern,*opts)
    else
      fnmatch(pattern,*opts)
    end
  end

end

class NilClass
  # Provide platform dependent null path.
  #
  # CREDIT Daniel Burger
  def to_path
    Pathname.null
  end
end


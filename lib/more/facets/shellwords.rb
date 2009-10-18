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
  #
  def shellwords
    opts, args = *flatten.partition{ |e| Hash === e }
    opts = opts.inject({}){ |m,h| m.update(h); m }
    opts.shellwords + args
  end

  def shelljoin
    Shellwords.shelljoin(shellwords)
  end

end

class Hash

  #
  def shellwords
    argv = []
    each do |f,v|
      m = f.to_s.size == 1 ? '-' : '--'
      case v
      when false, nil
      when Array
        v.each do |e|
          argv << %[#{m}#{f}="#{e}"]
        end
      when true
        argv << %[#{m}#{f}]
      else
        argv << %[#{m}#{f}="#{v}"]
      end
    end
    argv
  end

  #
  def shelljoin
    shellwords.shelljoin
  end

end


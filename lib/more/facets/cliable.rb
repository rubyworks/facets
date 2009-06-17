require 'clio/errors'

module Clio

  # = Commandable Mixin
  #
  # The Commandable mixin is a very quick and and easy
  # way to make almost any class usable via a command
  # line interface. It simply uses writer methods as
  # option setters, and the first command line argument
  # as the method to call, with the subsequent arguments
  # passed to the method.
  #
  # The only limitation of this approach (besides the weak
  # control of the process) is that required options must
  # be specified with the key=value notation.
  #
  #   class X
  #     include Clio::Commandable
  #
  #     attr_accessor :quiet
  #
  #     def bread(*args)
  #       ["BREAD", quiet, *args]
  #     end
  #
  #     def butter(*args)
  #       ["BUTTER", quiet, *args]
  #     end
  #   end
  #
  #   x = X.new
  #
  #   x.execute_command("butter yum")
  #   => ["BUTTER", nil, "yum"]
  #
  #   x.execute_command("bread --quiet")
  #   => ["BUTTER", true]
  #
  # Commandable also defines #command_missing and #option_missing,
  # which you can override to provide suitable results.
  #
  # TODO: Maybe command_missing is redundant, and method_missing would suffice?
  #
  module Commandable

    # Used to invoke the command.
    def execute_command(argv=ARGV)
      Commandable.run(self, argv)
    end

    # This is the fallback subcommand. Override this to provide
    # a fallback when no command is given on the commandline.
    def command_missing
      raise NoCommandError
    end

    # Override option_missing if needed.
    # This receives the name of the option and
    # the remaining arguments list. It must consume
    # any argument it uses from the (begining of)
    # the list.
    def option_missing(opt, *argv)
      raise NoOptionError, opt
    end

    class << self

      def run(obj, argv=ARGV)
        args = parse(obj, argv)
        subcmd = args.shift
        if subcmd && !obj.respond_to?("#{subcmd}=")
          obj.send(subcmd, *args)
        else
          obj.command_missing
        end
      end

      #def run(obj)
      #  methname, args = *parse(obj)
      #  meth = obj.method(methname)
      #  meth.call(*args)
      #end

      #
      def parse(obj, argv)
        case argv
        when String
          require 'shellwords'
          argv = Shellwords.shellwords(argv)
        else
          argv = argv.dup
        end

        argv = argv.dup
        args, opts, i = [], {}, 0
        while argv.size > 0
          case opt = argv.shift
          when /=/
            parse_equal(obj, opt, argv)
          when /^--/
            parse_option(obj, opt, argv)
          when /^-/
            parse_flags(obj, opt, argv)
          else
            args << opt
          end
        end
        return args
      end

      #
      def parse_equal(obj, opt, argv)
        if md = /^[-]*(.*?)=(.*?)$/.match(opt)
          x, v = md[1], md[2]
        else
          raise ArgumentError, "#{x}"
        end
        if obj.respond_to?("#{x}=")
          # TODO: to_b if 'true' or 'false' ?
          obj.send("#{x}=",v)
        else
          obj.option_missing(x, v) # argv?
        end
      end

      #
      def parse_option(obj, opt, argv)
        x = opt[2..-1]
        if obj.respond_to?("#{x}=")
          obj.send("#{x}=",true)
        else
          obj.option_missing(x, argv)
        end
      end

      #
      def parse_flags(obj, opt, args)
        x = opt[1..-1]
        c = 0
        x.split(//).each do |k|
          if obj.respond_to?("#{k}=")
            obj.send("#{k}=",true)
          else
            obj.option_missing(x, argv)
          end
        end
      end

    end #class << self

  end

end



=begin SPEC

  require 'quarry/spec'

  class X
    include Clio::Commandable

    attr_accessor :file
    attr_accessor :quiet

    attr :cmd

    #
    def bread(*args)
      @cmd = "BREAD"
    end

    #
    def butter(*args)
      @cmd = "BUTTER"
    end
  end

  Quarry.spec "Commandable" do

    verify "first command runs" do
      x = X.new
      x.execute_command("bread")
      x.cmd.assert == "BREAD"
    end

    verify "second command runs" do
      x = X.new
      x.execute_command("butter")
      x.cmd.assert == "BUTTER"
    end
  end

=end


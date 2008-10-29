require 'facets/core/kernel/instance_exec'

module MultipleDispatch

  class Dispatcher

    def initialize(name, lists)
      @name = name
      @lists = lists
    end

    def run(you, args)
      @lists.each do |list|
        catch(:mismatch) do
          return list.match(you, args)
        end
      end
      begin
        raise NoMethodError.new("undefined method `#{@name}' for #{you.inspect}:#{you.class}")
      rescue NoMethodError => e
        e.set_backtrace(e.backtrace[2..-1])
        raise e
      end
    end

  end

  class ArgumentList

    def initialize(required, optional, defaults, catch_all, catch_all_type, &action)
      @required = required
      @optional = optional
      @defaults = defaults
      @catch_all = catch_all
      @catch_all_type = catch_all_type
      @action = action
      calc_arity
    end

    def calc_arity
      @min_arity = @required.length
      @max_arity = (@min_arity + @optional.length unless @catch_all)
    end

    def match(you, args)
      throw :mismatch if args.length < @min_arity
      throw :mismatch if @max_arity && @max_arity < args.length
      (0...@required.length).each do |i|
        if ArgumentChanger === @required[i]
          args[i] = @required[i] === args[i]
        else
          throw :mismatch unless @required[i] === args[i]
        end
      end
      (@required.length...[args.length, @required.length + @optional.length].min).each do |i|
        if ArgumentChanger === @optional[i - @required.length]
          args[i] = @optional[i - @required.length] === args[i]
        else
          throw :mismatch unless @optional[i - @required.length] === args[i]
        end
      end
      (args.length - @required.length...@optional.length).each do |i|
        args << @defaults[i]
      end
      if @catch_all
        (@required.length + @optional.length...args.length).each do |i|
          if ArgumentChanger === @catch_all_type
            args[i] = @catch_all_type === args[i]
          else
            throw :mismatch unless @catch_all_type === args[i]
          end
        end
        you.instance_exec(*(args[0, @required.length + @optional.length] << args[@required.length + @optional.length..-1]), &@action)
      else
        you.instance_exec(*args, &@action)
      end
    end

  end

  module ArgumentChanger
    
  end

  class PropertyDispatch

    def initialize(&blk)
      @blk = blk
    end

    def ===(arg)
      @blk.call(arg)
    end

  end

  class CastDispatch

    include ArgumentChanger

    def initialize(type)
      @type = :"to_#{type}"
    end

    def ===(arg)
      arg.send(@type) rescue throw :mismatch
    end

    def changes_argument?
      true
    end

  end

  class AndDispatch
    
    def initialize(subterms)
      @subterms = subterms
    end

    def ===(arg)
      @subterms.each do |t|
        return false unless t === arg
      end
      true
    end

  end

  class OrDispatch

    def initialize(subterms)
      @subterms = subterms
    end

    def ===(arg)
      @subterms.each do |t|
        return true if t === arg
      end
      false
    end

  end

  class DontCareDispatch

    def initialize
      
    end

    def ===(arg)
      true
    end

  end

end

if __FILE__ == $0

  include MultipleDispatch

  class A

    def m(*args, &blk)
      # Argument list 1
      arg1 = ArgumentList.new([String, String], [], [], false, nil) do |s1, s2|
        yield [:two_strings, s1, s2]
      end
      # Argument list 2
      arg2 = ArgumentList.new([String, Integer], [], [], false, nil) do |s, i|
        yield [:string_and_integer, s, i]
      end
      # Argument list 3
      arg3 = ArgumentList.new([Integer, Integer, Integer], [], [], false, nil) do |i1, i2, i3|
        yield [:three_integers, i1, i2, i3]
      end
      # Argument list 4
      arg4 = ArgumentList.new([:do1, Integer], [], [], false, nil) do |_, i|
        yield [:do1, i]
      end
      # Argument list 5
      arg5 = ArgumentList.new([:do2, Integer], [], [], false, nil) do |_, i|
        yield [:do2, i]
      end
      # Argument list 6
      arg6 = ArgumentList.new([:do3, Integer], [Integer, String], [11, "extra"], false, nil) do |_, i1, i2, s|
        yield [:do3, i1, i2, s]
      end
      # Argument list 7
      arg7 = ArgumentList.new([:do4], [], [], true, Integer) do |_, args|
        yield [:do4, args]
      end
      # Argument list 8
      arg8 = ArgumentList.new([:do4], [], [], true, String) do |_, args|
        yield [:do4, args]
      end
      # Argument list 9
      arg9 = ArgumentList.new([PropertyDispatch.new { |a| :do5 === a }], [], [], false, nil) do |_|
        yield [:do5]
      end
      # Argument list 10
      arg10 = ArgumentList.new([/run/, DontCareDispatch.new], [], [], false, nil) do |i, dc|
        yield [:run, i, dc]
      end
      # Argument list 11
      arg11 = ArgumentList.new([:do6, CastDispatch.new(:sym)], [], [], false, nil) do |_, s|
        yield [:do6, s]
      end
      
      # Dispatcher
      d = Dispatcher.new(:'test', [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11])

      d.run(self, args)
    end

  end

  A.new.m("hello", "world") { |a| p a }
  A.new.m("world", 1) { |a| p a }
  A.new.m(1, 2, 3) { |a| p a }
  A.new.m(:do1, 1) { |a| p a }
  A.new.m(:do2, 2) { |a| p a }
  A.new.m(:do3, 3, 4, "a1") { |a| p a }
  A.new.m(:do3, 3, 4) { |a| p a }
  A.new.m(:do3, 3) { |a| p a }
  A.new.m(:do4) { |a| p a }
  A.new.m(:do4, 2) { |a| p a }
  A.new.m(:do4, 2, 3) { |a| p a }
  A.new.m(:do4, "2", "3") { |a| p a }
  A.new.m(:do5) { |a| p a }
  A.new.m("grunt", 1) { |a| p a }
  A.new.m("grunt", :a) { |a| p a }
  A.new.m(:do6, "hi") { |a| p a }

end


# TODO: hooks should be an inheritor
#
module Hook

  def self.append_features(base)
    base.extend self
  end

  def hooks
    @hooks ||= Hash.new{ |h,k| h[k] = [] }
  end

  def hook(name)
    name = name.to_sym

    (class << self; self; end).class_eval %{
      def #{name}(meth=nil, &blk)
        hooks[:#{name}] << (meth || blk)
      end
    }

    module_eval %{
      def #{name}(*args)
        self.class.hooks[:#{name}].each do |blk|
          if Proc === blk
            blk.call(:#{name}, *args)
          else
            __send__(blk, :#{name}, *args)
          end
        end
      end
    }
  end

end


#=begin demo

  class X
    include Hook

    hook :signal

    def boom(event, message)
      puts "Kaboom!"
    end

    signal do |event, message|
      puts "1", event, message
    end

    signal do |event, message|
      puts "2", event, message
    end

    signal :boom

  end

  X.new.signal("hi")

#=end


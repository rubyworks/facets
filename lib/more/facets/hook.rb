require 'facets/kernel/instance_exec'

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
            instance_exec(:#{name}, *args, &blk)
          else
            __send__(blk, :#{name}, *args)
          end
        end
      end
    }
  end

end


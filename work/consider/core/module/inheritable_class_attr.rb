class Module

  def inheritable_class_attr(*attributes, &block)
    attributes.each do |attribute|
      accessor = "_#{attribute}"
      meta_def(attribute) do |*args|
        if args.empty?
          send(accessor)
        else
          # If the block takes an argument, use it as a filter.
          if block and block.arity == 1
            meta_def(accessor) { block.call(args.first) }
          else
            meta_def(accessor) { args.first }
          end
        end
      end

      # Default value.
      if block and block.arity < 1
        meta_def(accessor, &block)
      end
    end
  end

end

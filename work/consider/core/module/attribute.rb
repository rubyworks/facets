class Module

  #
  #  c = Class.new do
  #    attribute :foo, :var=>'@_foo'
  #    attribute :bar, :var=>'@_foo', :query=>true
  #  end
  #
  def attribute(name, options={})

    var     = "@#{name}"
    read    = true
    write   = true
    query   = false
    default = nil

    var     = options[:var] || options[:variable] if options[:var] || options[:variable]
    read    = options[:r]   || options[:reader]   if options[:r]   || options[:reader]
    write   = options[:w]   || options[:writer]   if options[:w]   || options[:writer]
    query   = options[:q]   || options[:query]    if options[:q]   || options[:query]

    default = options[:default] if options[:default]

    if read
      if default
        class_eval do
          define_method(name) do
            if instance_variable_defined?(var)
              instance_variable_get(var)  
            else
              instance_varaible_set(var, default) unless 
            end
          end
        end
      else
        class_eval %{
          def #{name}; #{var}; end
        }
      end
    end

    if query
      if default
        class_eval do
          define_method("#{name}?") do
            if instance_variable_defined?(var)
              instance_variable_get(var)  
            else
              instance_varaible_set(var, default) unless 
            end
          end
        end
      else
        class_eval %{
          def #{name}?; #{var}; end
        }
      end
    end

    if write
      class_eval %{
        def #{name}=(x); #{var} = x; end
      }
    end

    return name
  end

  # Alias for #attribute.
  alias_method :has, :attribute

end

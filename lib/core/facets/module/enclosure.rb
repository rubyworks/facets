class Module

  # Returns the module which contains this one according to its name.
  #
  #   module ::EncExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   EncExample::M::N.enclosure  #=> EncExample::M
  #
  # The enclosure of top-level and anonymous modules is Object.
  #
  #   EncExample.enclosure   #=> Object
  #   Module.new.enclosure   #=> Object
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/module/enclosure'
  #
  def enclosure
    name = /::[^:]+\Z/ =~ self.name ? $` : nil
    if name
      #base = name.sub!(/^::/, '') ? Object : self
      name.split(/::/).inject(self) do |mod, cref|
        if /\:(0x.*?)\>$/ =~ cref   # TODO: does this ever happen?
          #p $1.to_i(16)
          ObjectSpace._idref($1.to_i(16))
        else
          mod.const_get(cref)
        end
      end
    else
      Object
    end
  end

  # Returns all the namespaces of this module according ordered from
  # nearest and moving outwards. The receiver is not contained within
  # the result.
  #
  #   module ::EncExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   EncExample.enclosures        #=> [Object]
  #   EncExample::M.enclosures     #=> [EncExample, Object]
  #   EncExample::M::N.enclosures  #=> [EncExample::M, EncExample, Object]
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/module/enclosures'
  #
  def enclosures
    n = []
    name.split(/::/).inject(self) do |mod, cref|
      c = mod.const_get(cref) ; n.unshift(c) ; c
    end
    n << Object # ?
    n.shift # we really don't need +self+ too.
    n
  end

  # Enclosure name.
  #
  #   module ::EncExample
  #     module M
  #       module N
  #       end
  #     end
  #   end
  #
  #   EncExample::M::N.encname  #=> "EncExample::M"
  #
  # NOTE: This method is not a common core extension and is not
  # loaded automatically when using <code>require 'facets'</code>.
  #
  # @uncommon
  #   require 'facets/module/enclosure'
  #
  def encname
    /::[^:]+\Z/ =~ self.name ? $` : nil
  end

end

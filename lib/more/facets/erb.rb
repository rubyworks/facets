require 'erb'

# = OpenTemplate
#
# The Erb OpenTemplate provides a quick and convenient way to
# create a clean rendering space with the desired responses.
#
# TODO: This might make a good addon library. Just add 
# require 'erb' to the erb_result method? Call it OpenResponse?
#
class ERB::OpenTemplate

  # TODO: Should we do this? Perhaps offer it as an option?
  instance_methods.each do |m|
    undef_method(m) unless /^(__|instance_|inspect$|extend$)/ =~ m.to_s
  end

  #
  def initialize(*objs_ioc)
    ioc = Hash===objs_ioc.last ? objs_ioc.pop : {}
    objs = objs_ioc

    mods = []

    objs.each do |obj|
      mod = Module.new
      obj.public_methods.each do |m|
        mod.module_eval do
          define_method(m){ |*a,&b| obj.__send__(m,*a,&b) }
        end
      end
      mods << mod
    end

    mod = Module.new
    ioc.each do |k,v|
      mod.module_eval do
        define_method(k){ v }
      end
    end
    mods << mod

    extend *mods.reverse
  end

  #
  def erb_result(str)
    ERB.new(str).result(binding)
  end

  #
  #def method_missing(sym, *args, &block)
  #  #if @ioc.key?(sym)
  #  #  @ioc[sym]
  #  if obj = @objs.find{ |o| o.respond_to?(sym) }
  #    obj.__send__(sym, *args, &block)
  #  else
  #    super
  #  end
  #end

end


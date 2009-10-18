require 'erb'

# = OpenTemplate
#
# The Erb OpenTemplate provides a quick and conenient way to create a clean rendering
# space with out the defined response desired.
#
# TODO: Perhaps can be improved by using singletons instead of method_missing.
#
class ERB::OpenTemplate

  instance_methods.each do |m|
    undef_method(m) unless /^(__|instance_|inspect$)/ =~ m.to_s
  end

  #
  def initialize(*objs_ioc)
    ioc = Hash===objs_ioc.last ? objs_ioc.pop : {}
    @objs = objs_ioc

    ioc.each do |k,v|
      (class << self; self; end).module_eval do
        define_method(k){ v }
      end
    end
  end

  #
  def erb_result(str)
    ERB.new(str).result(binding)
  end

  #
  def method_missing(sym, *args, &block)
    #if @ioc.key?(sym)
    #  @ioc[sym]
    if obj = @objs.find{ |o| o.respond_to?(sym) }
      obj.__send__(sym, *args, &block)
    else
      super
    end
  end

end


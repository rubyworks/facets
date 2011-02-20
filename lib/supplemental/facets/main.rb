# = Main as Module
#
# Main, ie. the top-level object, is not fully in-sync with
# Module. So, certain methods like #define_method do not work.
# This library fixes this.
#
# Techinally it is this authors opinion that the top-level object
# most likely would be better-off as a self-extended module, and
# methods defined in it do not automatically get added to the
# Object class.
#
# On the other hand. It is probably best to never use the toplevel
# except as a jumping in point to youre own namespace.
#
# Note that none of this would be needed if Main were just a self extended
# module.

def_meth = Proc.new do |m|
  if /=$/ =~ m.to_s
    eval <<-END
      def self.#{m}(arg)
        Object.class_eval do
          #{m}(arg)
        end
      end
    END
  else
    eval <<-END
      def self.#{m}( *args, &block )
        Object.class_eval do
          #{m}( *args, &block )
        end
      end
    END
  end
end

public

(Module.public_instance_methods - public_methods).each do |m|
  next if m == "initialize"
  next if m =~ /^\W+$/
  def_meth[m]
end

private

(Module.private_instance_methods - private_methods).each do |m|
  next if m == "initialize"
  next if m =~ /^\W+$/
  def_meth[m]
end

protected

(Module.protected_instance_methods - protected_methods).each do |m|
  next if m == "initialize"
  next if m =~ /^\W+$/
  def_meth[m]
end

# Copyright (c) 2006 Thomas Sawyer (Ruby License)

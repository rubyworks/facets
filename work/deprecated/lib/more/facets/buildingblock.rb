# = buildingblock.rb
#
# == Copyright (c) 2006 Thomas Sawyer
#
#   Ruby License
#
#   This module is free software. You may use, modify, and/or redistribute this
#   software under the same terms as Ruby.
#
#   This program is distributed in the hope that it will be useful, but WITHOUT
#   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#   FOR A PARTICULAR PURPOSE.
#
# == Authors and Contributors
#
#   CREDIT Thomas Sawyer

# = BuildingBlock
#
# Build content programatically with Ruby and Ruby's blocks.
#
#   require 'facets'
#   require 'xmlhelper'
#
#   builder = BuildingBlock.new(XMLHelper, :element)
#
#   doc = builder.html do
#
#     head do
#       title "Test"
#     end
#
#     body do
#       i "Hello"
#       br
#       text "Test"
#       text "Hey"
#     end
#
#   end
#
# _produces_
#
#   <html><head><title>Test</title><body><i>Hello</i><br />TestHey</body></html>
#
# All calls within the block are routed via the Helper Module's constructor method
# (#element in the above example) unless they are defined by the helper module, in which
# case they are sent to the helper module directly. The results of these invocations are
# appended to the output buffer. To prevent this, prefix the method with 'call_'.
#
# Sometimes keywords can get in the way of a construction. In these cases you can
# ensure use of constructor method by calling the special #build! command. You can
# also add verbatium text to the output via the #<< operator. All of Ruby's built-in
# keywords (eg. 'while', 'if', 'until', etc.) and the following methods are treated as
# keywords.
#
#      method_missing
#      initialize
#      inspect
#      to_str
#      to_s
#      respond_to?
#      singleton_method_undefined
#
# This work was of course inspired by many great minds, and represents a concise and simple
# means of accomplishing this pattern of design, which is unique to Ruby.

class BuildingBlock

  alias _p p

  ESCAPE = [
    'singleton_method_undefined',
    'method_missing',
    'respond_to?',
    'initialize',
    'inspect',
    'to_str',
    'to_s',
    '<<',
    'build!',
    'call',
    '_p'
  ] # 'to_ary', 'p' ]

  def initialize(helper_module, constructor_method, output_buffer=nil)
    @module        = helper_module
    @constructor   = constructor_method
    @instance_eval = method(:instance_eval)

    @method = {}

    meths = []
    #meths.concat singleton_methods
    meths.concat public_methods
    meths.concat protected_methods
    meths.concat private_methods
    meths.each do |m|
      @method[m.to_sym] = method(m)
    end

    class << self
      escape = ESCAPE
      meths = []
      #meths.concat singleton_methods
      meths.concat public_instance_methods
      meths.concat protected_instance_methods
      meths.concat private_instance_methods
      meths.each do |m|
        undef_method(m) unless m =~ /^__/ or escape.include?(m)
      end
    end

    @stack = []
    @out   = output_buffer || ''
  end

  def method_missing(s, *a, &b)
_p s
    s = s.to_s

    if b
      @stack << @out
      @out = ''
      @instance_eval.call(&b)
      out = @out
      @out = @stack.pop
      a.unshift(out)
    end

    if s =~ /^call_/
      m = s[5..-1].to_sym
      @module.send(m, *a, &b).to_s
    elsif @module.respond_to?(s) #o =~ /^build_/
      @out << @module.send(s, *a, &b).to_s
    else
      s = s.chomp('?') if s[-1,1] == '?'
      @out << @module.send(@constructor, s, *a).to_s
    end
  end

  def to_s() @out end
  def to_str() @out end

  def <<(s)
    @out << s.to_s
  end

  # If creating and XML/HTML builder, you'll want to alias this to tag!.
  def build!(m, *a)
    @out << @module.send(@constructor, m, *a).to_s
  end

  #
  def call(&b)
_p "HHHHHHHHHHHHHHH"
_p self
    @instance_eval.call(&b)
  end

  # Could improve.

  def inspect
    r = super
    i = r.index(',')
    return r[0...i] + ">"
  end

end



#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#

=begin test
  require 'test/unit'

  class TestBuildingBlock < Test::Unit::TestCase

    module M
      extend self
      def m(n,*m) ; "#{n}{#{m}}"; end
      def t(n) ; "#{n}"; end
    end

    def test_01
      build = BuildingBlock.new(M, :m)

      build.html do
        head do
          title "Test"
        end

        body do
          i "Hello"
          build! :not
          t "Test"
          t "Hey"
        end
      end

      r = "html{head{title{Test}}body{i{Hello}not{}TestHey}}"

      assert_equal( r, build.to_s )
    end

  end

=end


# Author::    Thomas Sawyer
# Copyright:: Copyright (c) 2007 Thomas Sawyer
# License::   Ruby License

require 'facets/functor'

class String

  # Create a mask.
  def to_mask(re=nil)
    Mask.new(self,re)
  end

  # = Mask
  #
  class Mask

    ESC = "\032" # ASCII SUBSTITUTE

  class << self

    def [](string, re=nil)
      new(string, re)
    end

    end # class<< self

  protected

    attr :string

  private

    def initialize(string, re=nil)
      @string = string.dup
      mask!(re) if re
    end

  public

    def inspect ; string.inspect ; end
    def to_s    ; string ; end

    def [](*a)
      string[*a]
    end

    def mask(re)
      self.class.new(string,re)
    end

    def mask!(re)
      string.gsub!(re){ |s| ESC * s.size }
    end

    # Mask subtraction. Where the characters are the same,
    # the result is "empty", where they differ the result
    # reflects the last string.
    #
    #     "abc..123"      "ab..789."
    #   - "ab..789."    - "abc..123"
    #     ----------      ----------
    #     "....789."      "..c..123"
    #
    def -(other)
      i = 0
      o = ''
      while i < string.size
        if string[i,1] == other[i,1]
          o << ESC
        else
          o << other[i,1]
        end
        i += 1
      end
      self.class.new(o)
    end

    # Mask ADD. As long as there is a value other
    # then empty the character filters though.
    # The last string takes precedence.
    #
    #     "abc..123"      "ab..789."
    #   + "ab..789."    + "abc..123"
    #     ----------      ----------
    #     "abc.7893"      "abc.7123"
    #
    def +(other)
      i = 0
      o = ''
      while i < string.size
        if other[i,1] == ESC
          o << string[i,1]
        else
          o << other[i,1]
        end
        i += 1
      end
      self.class.new(o)
    end

    # Mask OR is the same as ADD.
    alias_method :|, :+

    # Mask XAND. Where the characters are the same, the
    # result is the same, where they differ the result
    # reflects the later.
    #
    #     "abc..123"      "ab..789."
    #   * "ab..789."    | "abc..123"
    #     ----------      ----------
    #     "ab..789."      "abc..123"
    #
    def *(other)
      i = 0
      o = ''
      while i < string.size
        if (c = string[i,1]) == other[i,1]
          o << c
        else
          o << other[i,1]
        end
        i += 1
      end
      self.class.new(o)
    end

    # Mask AND. Only where they are
    # then same filters through.
    #
    #     "abc..123"      "ab..789."
    #   & "ab..789."    | "abc..123"
    #     ----------      ----------
    #     "ab......"      "ab......"
    #
    def &(other)
      i = 0
      o = ''
      while i < string.size
        if (c = string[i,1]) == other[i,1]
          o << c
        else
          o << ESC
        end
        i += 1
      end
      self.class.new(o)
    end

    # Mask XOR operation. Only where there
    # is an empty slot will the value filter.
    #
    #     "abc..123"      "ab..789."
    #   | "ab..789."    | "abc..123"
    #     ----------      ----------
    #     "..c.7..3"      "..c.7..3"
    #
    def ^(other)
      i = 0
      o = ''
      while i < string.size
        if string[i,1] == ESC
          o << other[i,1]
        elsif other[i,1] == ESC
          o << string[i,1]
        else
          o << ESC
        end
        i += 1
      end
      self.class.new(o)
    end

    #
    def ==(other)
      case other
      when String::Mask
        string == other.string
      else
        string == other.to_s
      end
    end

    # Apply a method to the internal string
    # and return a new mask.
    def apply(s=nil,*a,&b)
      if s
        string.send(s,*a,&b).to_mask
      else
        @_self ||= Functor.new do |op, *a|
          string.send(op,*a).to_mask
        end
      end
    end

    def replace(string)
      @string = string.to_s
    end

    def instance_delegate
      @string
    end

    # Functor on the interal string.
    #def self
    #  @_self ||= Functor.new do |op, *a|
    #    @string = @string.send(op, *a)
    #  end
    #end

    # Delegate any missing methods to underlying string.
    #
    def method_missing(s, *a, &b)
      begin
        str = string.send(s, *a, &b)
      rescue NoMethodError
        super(s, *a, &b)
      end
    end

  end
end


=begin spec

  require 'quarry/spec'

  Quarry.spec "String::Mask" do

    x1 = String::Mask["abc..123", '.']
    x2 = String::Mask["ab..789.", '.']

    verify "sub" do
      r = x1 - x2
      a = String::Mask["....789.", '.']
      r.assert == a
      r = x2 - x1
      a = String::Mask["..c..123", '.']
      r.assert == a
    end

    verify "add" do
      r = x1 + x2
      a = String::Mask["abc.7893", '.']
      r.assert == a
      r = x2 + x1
      a = String::Mask["abc.7123", '.']
      r.assert == a
    end

    verify "xand" do
      r = x1 * x2
      a = String::Mask["ab..789.", '.']
      r.assert == a
      r = x2 * x1
      a = String::Mask["abc..123", '.']
      r.assert == a
    end

    verify "and" do
      r = x1 & x2
      a = String::Mask["ab......", '.']
      r.assert == a
      r = x2 & x1
      a = String::Mask["ab......", '.']
      r.assert == a
    end

    verify "xor" do
      r = x1 ^ x2
      a = String::Mask["..c.7..3", '.']
      r.assert == a
      r = x2 ^ x1
      a = String::Mask["..c.7..3", '.']
      r.assert == a
    end

  end

=end


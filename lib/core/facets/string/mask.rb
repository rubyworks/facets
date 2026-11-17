class String

  # Make a mask of the string, in which each `re` is an empty slot.
  # See String::Mask.
  #
  #     m = "abc..123".mask('.')
  #     (m + "ab..789.").to_s   #=> "abc.7893"
  #
  # re - The character that marks an empty slot. [String]
  #
  # Returns a new mask. [String::Mask]
  #
  # @uncommon
  #   require 'facets/string/mask'
  #
  # Since: 4.2.0

  def mask(re=nil)
    Mask.new(self, re)
  end

  # A Mask is a string in which some characters are empty slots. Masks
  # of the same length combine character by character, with operators
  # that work like those of sets or bits.
  #
  #     m1 = String::Mask.new("abc..123", '.')
  #     m2 = "ab..789.".mask('.')
  #
  #     (m1 + m2).to_s   #=> "abc.7893"
  #     (m1 - m2).to_s   #=> "....789."
  #     (m1 & m2).to_s   #=> "ab......"
  #     (m1 ^ m2).to_s   #=> "..c.7..3"
  #
  # The second operand can be an ordinary string, which is read as a
  # mask with the same empty-slot character as the first.
  #
  #     ("abc..123".mask('.') + "ab..789.").to_s   #=> "abc.7893"
  #
  # Where one mask is shorter than the other, its missing characters
  # count as empty slots.
  #
  # Without an empty-slot character, the ASCII substitute character
  # (`"\x1A"`, Mask::ESC) marks an empty slot. That is the better choice
  # when "." or any other printable character might be part of the text.
  #
  # Methods a mask doesn't have are passed to its string, so
  # `mask.size` and `mask.upcase` work as they do for a string.
  #
  # Based on the Strmask gem, which began as Facets' `string/mask`.
  #
  # Since: 4.2.0
  # Author: Trans

  class Mask

    # The character that stands for an empty slot inside a mask: ASCII
    # substitute.
    ESC = "\032"

    # Make a mask. Same as Mask.new.
    #
    # Returns a new mask. [String::Mask]
    def self.[](string, re=nil)
      new(string, re)
    end

    # string - Any string, or the string of another mask. [String]
    # re     - The character that marks an empty slot. [String]
    def initialize(string, re=nil)
      @to_str = string.to_str.dup
      @re     = re || ESC
      mask!(re) if re
    end

    # The underlying string, in which ESC marks each empty slot.
    #
    # Returns the string. [String]
    def to_str
      @to_str
    end

    # The mask as an ordinary string, with the empty-slot character it
    # was made with.
    #
    # Returns a new string. [String]
    def to_s
      @to_str.gsub(ESC, @re)
    end

    #
    def inspect
      to_s.inspect
    end

    # Index into the underlying string.
    def [](*a)
      to_str[*a]
    end

    # A mask of the same underlying string with another empty-slot
    # character.
    #
    # re - The character that marks an empty slot. [String]
    #
    # Returns a new mask. [String::Mask]
    def mask(re)
      self.class.new(to_str, re)
    end

    # Turn each `re` in this mask into an empty slot.
    #
    # Returns this mask. [String::Mask]
    def mask!(re)
      to_str.gsub!(re){ |s| ESC * s.size }
      self
    end

    # Mask subtraction. Where the characters are the same, the result is
    # empty; where they differ, the result is the other's.
    #
    #     a = "abc..123".mask('.')
    #     b = "ab..789.".mask('.')
    #
    #     (a - b).to_s   #=> "....789."
    #     (b - a).to_s   #=> "..c..123"
    #
    def -(other)
      combine(other){ |a, b| a == b ? ESC : b }
    end

    # Mask addition. The other's character comes through unless it is
    # empty, in which case this mask's does.
    #
    #     a = "abc..123".mask('.')
    #     b = "ab..789.".mask('.')
    #
    #     (a + b).to_s   #=> "abc.7893"
    #     (b + a).to_s   #=> "abc.7123"
    #
    def +(other)
      combine(other){ |a, b| b == ESC ? a : b }
    end

    # Mask OR is the same as addition.
    alias_method :|, :+

    # Mask XAND. Where the characters are the same, the result is the
    # same; where they differ, the result is the other's.
    #
    #     a = "abc..123".mask('.')
    #     b = "ab..789.".mask('.')
    #
    #     (a * b).to_s   #=> "ab..789."
    #     (b * a).to_s   #=> "abc..123"
    #
    def *(other)
      combine(other){ |a, b| a == b ? a : b }
    end

    # Mask AND. Only characters that are the same come through.
    #
    #     a = "abc..123".mask('.')
    #     b = "ab..789.".mask('.')
    #
    #     (a & b).to_s   #=> "ab......"
    #     (b & a).to_s   #=> "ab......"
    #
    def &(other)
      combine(other){ |a, b| a == b ? a : ESC }
    end

    # Mask XOR. A character comes through only where the other mask has
    # an empty slot.
    #
    #     a = "abc..123".mask('.')
    #     b = "ab..789.".mask('.')
    #
    #     (a ^ b).to_s   #=> "..c.7..3"
    #     (b ^ a).to_s   #=> "..c.7..3"
    #
    def ^(other)
      combine(other) do |a, b|
        if a == ESC then b
        elsif b == ESC then a
        else ESC
        end
      end
    end

    # Masks are equal if they have the same characters and the same
    # empty slots, whatever character each was made with. A mask is
    # never equal to an ordinary string: compare its `to_s` instead.
    #
    #     "abc..123".mask('.') == "abc__123".mask('_')   #=> true
    #     "abc..123".mask('.') == "abc..123"             #=> false
    #     "abc..123".mask('.').to_s == "abc..123"        #=> true
    #
    def ==(other)
      Mask === other && to_str == other.to_str
    end

    alias_method :eql?, :==

    #
    def hash
      to_str.hash
    end

    # Call a method on the underlying string and make a mask of the
    # result.
    #
    #     "abc..123".mask('.').apply(:upcase).to_s   #=> "ABC..123"
    #
    # Returns a new mask. [String::Mask]
    def apply(op, *a, &b)
      self.class.new(to_str.public_send(op, *a, &b), @re)
    end

    # Replace the underlying string.
    #
    # Returns this mask. [String::Mask]
    def replace(string)
      @to_str = string.to_s.dup
      self
    end

    # Pass any other method to the underlying string.
    def method_missing(s, *a, &b)
      if to_str.respond_to?(s)
        to_str.public_send(s, *a, &b)
      else
        super
      end
    end

    #
    def respond_to_missing?(s, include_all=false)
      to_str.respond_to?(s) || super
    end

  private

    # Read anything that isn't a mask as one with this mask's empty-slot
    # character.
    def convert(other)
      Mask === other ? other : self.class.new(other.to_str, @re)
    end

    # A new mask made by giving the block each pair of characters, with
    # ESC standing in past the end of the shorter mask.
    def combine(other)
      other = convert(other).to_str
      out   = String.new(encoding: to_str.encoding)
      [to_str.size, other.size].max.times do |i|
        out << yield(to_str[i] || ESC, other[i] || ESC)
      end
      self.class.new(out, @re)
    end

  end

end

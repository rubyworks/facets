# = Blank
#
# Core extension method #blank? added to core clesses.

#
module Kernel
  # An object is blank if it's nil, empty, or a whitespace string.
  # For example, "", "   ", nil, [], and {} are blank.
  #
  # This simplifies
  #   if !address.nil? && !address.empty?
  # to
  #   if !address.blank?
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end

class NilClass
  def blank?
    true
  end
end

class FalseClass
  def blank?
    true
  end
end

class TrueClass
  def blank?
    false
  end
end

class Array
  alias_method :blank?, :empty?
end

class Hash
  alias_method :blank?, :empty?
end

class String
  # Is this string just whitespace?
  #
  #   "abc".blank?  #=> false
  #   "   ".blank?  #=> true
  def blank?
    self !~ /\S/
  end
end

class Numeric
  def blank?
    false
  end
end


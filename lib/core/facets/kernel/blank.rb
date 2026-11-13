module Kernel
  # An object is blank if it's nil, empty, or a whitespace string.
  # For example, "", "   ", nil, [], and {} are blank.
  #
  # This simplifies:
  #
  #   if !address.nil? && !address.empty?
  #
  # to:
  #
  #   if !address.blank?
  #
  def blank?
    return empty? if respond_to?(:empty?)
    !self
  end

  # An object is present if it's not blank.
  def present?
    !blank?
  end

  # Returns object if it's #present? otherwise returns nil.
  # object.presence is equivalent to object.present? ? object : nil.
  #
  # This is handy for any representation of objects where blank is the same
  # as not present at all.  For example, this simplifies a common check for
  # HTTP POST/query parameters:
  #
  #   state   = params[:state]   if params[:state].present?
  #   country = params[:country] if params[:country].present?
  #   region  = state || country || 'US'
  #
  # becomes:
  #
  #   region = params[:state].presence || params[:country].presence || 'US'
  #
  def presence
    self if present?
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
  # Is this string empty or just whitespace? Unicode whitespace, such as a
  # non-breaking space, counts too, as it does in ActiveSupport.
  #
  #   "abc".blank?     #=> false
  #   "   ".blank?     #=> true
  #   " ".blank?  #=> true
  def blank?
    empty? || /\A[[:space:]]*\z/.match?(self)
  rescue Encoding::CompatibilityError
    # e.g. UTF-16 text, which a UTF-8 regexp can't match
    Regexp.new('\A[[:space:]]*\z'.encode(encoding), Regexp::FIXEDENCODING).match?(self)
  end
end

class Numeric
  def blank?
    false
  end
end


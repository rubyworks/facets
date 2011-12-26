require 'e2mmap'

module Euclid

  class Matrix

    module Exceptions # :nodoc:
      extend Exception2MessageMapper

      def_e2message(TypeError, "wrong argument type %s (expected %s)")
      def_e2message(ArgumentError, "Wrong # of arguments(%d for %d)")

      def_exception("ErrDimensionMismatch", "\#{self.name} dimension mismatch")
      def_exception("ErrNotRegular", "Not Regular Matrix")
      def_exception("ErrOperationNotDefined", "This operation(%s) can\\'t defined")
    end

    #  extend Exception2MessageMapper
    include Exceptions

  end

end


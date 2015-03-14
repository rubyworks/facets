## Module#include_as

    require 'facets/module/include_as'

Module#include_as utilizes #method_space to allow modules to be included
within a separated namespace.

    module T
      def t ; "Tt"  ; end
      def r ; "Tr"  ; end
      def q ; super ; end
    end

    class N
      def q ; "Nq" ; end
    end

    class X < N
      include_as :test => T

      def n ; test.inspect ; end
      def m ; test.t ; end
      def o ; test.r ; end
    end

    x = X.new

    x.m.assert == "Tt"
    x.o.assert == "Tr"
    x.q.assert == "Nq"


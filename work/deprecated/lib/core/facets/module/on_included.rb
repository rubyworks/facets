class Module

  # DEPRECATED
  #   # Both includes and extends a module.
  #   #
  #   #   NOTE: If #include and/or #extend returned thier modules then
  #   #         one could just do:
  #   #
  #   #             extend(*include(M1, M2, ...))
  #   #
  #   #   CREDIT: Trans
  #
  #   def include_and_extend(*mods)
  #     include *mods
  #     extend *mods
  #   end

  # NOTE: include_as is now in more library namespace.rb.

  # A macro for dynamic modules.
  #
  #    TODO: This method ecourages a bad practice, and should not be used.
  #          It's here because Nitro uses it, but eventually it will be deprecated.
  #
  #  CREDIT: George Moschovitis

  def on_included(code)
    tag = caller[0].split(' ').first.split(/\/|\\/).last.gsub(/:|\.|\(|\)/, '_')
    old = "__included_#{tag}"
    module_eval %{
      class << self
        alias_method :#{old}, :included
        def included(base)
          #{old}(base)
          #{code}
        end
      end
    }
  end

end


=begin

  require 'test/unit'

  class TestOnInclude < Test::Unit::TestCase

    module M
      def self.check ; @@check ; end
      on_included %{
        @@check = 1
      }
    end

    module Q
      def self.check ; @@check ; end
      on_included %{
        @@check = 1
      }
      on_included %{
        @@check = 2
      }
    end

    class C
      include M
      include Q
    end

    def test_included
      assert_equal(1, M.check)
      assert_equal(2, Q.check)
    end

  end

=end


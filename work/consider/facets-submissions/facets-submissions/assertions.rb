module Test::Unit::Assertions
  # The built in assert_raise doesn't work for subclasses, etc. That is, if I have
  # UngrammaticalException and FragmentException < UngrammaticalException assert_raise
  # UngrammaticalException will fail if the method throws FragmentException. It will only pass for
  # UngrammaticalException.
  #
  # This code is basically the same as the original assert_raise (which, in my opinion, should make
  # the above work). _expected_exception? just needed to be modified. I'm tempted to just change that
  # method itself, but I don't want clients of these modifications to have unexpected behavior.
  #
  #
  # Original:
  #
  # File test/unit/assertions.rb, line 111
  # def assert_raise(*args)
  #   _wrap_assertion do
  #     if Module === args.last
  #       message = ""
  #     else
  #       message = args.pop
  #     end
  #     exceptions, modules = _check_exception_class(args)
  #     expected = args.size == 1 ? args.first : args
  #     actual_exception = nil
  #     full_message = build_message(message, "<?> exception expected but none was thrown.", expected)
  #     assert_block(full_message) do
  #       begin
  #         yield
  #       rescue Exception => actual_exception
  #         break
  #       end
  #       false
  #     end
  #     full_message = build_message(message, "<?> exception expected but was\n?", expected, actual_exception)
  #     assert_block(full_message) {_expected_exception?(actual_exception, exceptions, modules)}
  #     actual_exception
  #   end
  # end
  def assert_raise_kind_of(*args)
    _wrap_assertion do
      if Module === args.last
        message = ""
      else
        message = args.pop
      end
      exceptions, modules = _check_exception_class(args)
      expected = args.size == 1 ? args.first : args
      actual_exception = nil
      full_message = build_message(message, "<?> exception expected but none was thrown.", expected)
      assert_block(full_message) do
        begin
          yield
        rescue Exception => actual_exception
          break
        end
        false
      end
      full_message = build_message(message, "<?> exception expected but was\n?", expected, actual_exception)
      assert_block(full_message) {_expected_kind_of_exception?(actual_exception, exceptions, modules)}
      actual_exception
    end
  end
  
  # Original:
  #
  # # File test/unit/assertions.rb, line 97
  # def _expected_exception?(actual_exception, exceptions, modules) # :nodoc:
  #   exceptions.include?(actual_exception.class) or
  #     modules.any? {|mod| actual_exception.is_a?(mod)}
  # end
  def _expected_kind_of_exception?(actual_exception, exceptions, modules) # :nodoc:
    exceptions.any? {|exception| actual_exception.kind_of?(exception)} or
      modules.any? {|mod| actual_exception.is_a?(mod)}
  end
end
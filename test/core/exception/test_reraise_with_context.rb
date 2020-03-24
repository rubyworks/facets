covers 'facets/kernel/reraise_with_context'
covers 'facets/exception/reraise_with_context'
covers 'facets/enumerable/reraise_with_context'

test_case Kernel do
  method :reraise_with_context do
    test 'simple' do
      reraise_with_context(some: 'context') do
        0.supercalafragalistic
      end rescue (exc = $!)
      exc.assert.is_a? NoMethodError
      exc.context.assert == {some: 'context'}
    end

    test 'simple' do
      reraise_with_context(NameError, some: 'context') do
        0.supercalafragalistic
      end rescue (exc = $!)
      exc.assert.is_a? NoMethodError
      exc.context.assert == {some: 'context'}
    end

    test 'non-matching exception class' do
      reraise_with_context(RuntimeError, some: 'context') do
        0.supercalafragalistic
      end rescue (exc = $!)
      exc.assert.is_a? NoMethodError
      exc.context.assert == nil
    end

    test 'adding context from a loop' do
      [2, 1, 0].each do |n|
        reraise_with_context(n: n) do
          10 / n
        end
      end rescue (exc = $!)
      exc.assert.is_a? ZeroDivisionError
      exc.context.assert == {n: 0}
    end
  end
end

test_case Exception do
  class_method :reraise_with_context do
    test 'simple' do
      NameError.reraise_with_context(some: 'context') do
        0.supercalafragalistic
      end rescue (exc = $!)
      exc.assert.is_a? NoMethodError
      exc.context.assert == {some: 'context'}
    end

    test 'non-matching exception class' do
      RuntimeError.reraise_with_context(some: 'context') do
        0.supercalafragalistic
      end rescue (exc = $!)
      exc.assert.is_a? NoMethodError
      exc.context.assert == nil
    end

    test 'adding context from a loop' do
      [3, 2, 1, 0].each do |n|
        StandardError.reraise_with_context(n: n) do
          10 / n
        end
      end rescue (exc = $!)
      exc.context.assert == {n: 0}
    end
  end
end

test_case Enumerable do
  method :reraise_with_context do
    test 'reraise_with_context.each' do
      [2, 1, 0].reraise_with_context.each do |n|
        10 / n
      end rescue (exc = $!)
      exc.assert.is_a? ZeroDivisionError
      exc.context.assert == {args: [0]}
    end

    test 'each.with_index.reraise_with_context' do
      enum = [2, 1, 0].each.with_index.reraise_with_context
      enum.each do |n, i|
        10 / n
      end rescue (exc = $!)
      exc.assert.is_a? ZeroDivisionError
      exc.context.assert == {args: [0, 2]}
    end
  end
end

test_case Enumerator::Lazy do
  method :reraise_with_context do
    test 'lazy.reraise_with_context' do
      enum = (-1..Float::INFINITY).lazy.reraise_with_context do |n|
        10 / n
      end
      enum.assert.is_a? Enumerator::Lazy
      enum.first(3) rescue (exc = $!)
      exc.assert.is_a? ZeroDivisionError
      exc.context.assert == {args: [0]}
    end

    test 'lazy.with_index.reraise_with_context' do
      enum = (-2..Float::INFINITY).lazy.with_index.reraise_with_context do |n, i|
        10 / n
      end
      enum.assert.is_a? Enumerator::Lazy
      enum.first(3) rescue (exc = $!)
      exc.assert.is_a? ZeroDivisionError
      exc.context.assert == {args: [0, 2]}
    end
  end
end

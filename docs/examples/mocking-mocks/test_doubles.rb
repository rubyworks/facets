# frozen_string_literal: true

# Keep this standalone example independent of installed test-runner plugins.
ENV['MT_NO_PLUGINS'] = '1'
gem 'minitest', '~> 5.25'
require 'minitest/autorun'
require 'minitest/mock'

class ReceiptSender
  def initialize(mailer)
    @mailer = mailer
  end

  def call(to:, amount_cents:)
    @mailer.deliver(to: to, body: "Received #{amount_cents} cents.")
  end
end

class RecordingMailer
  attr_reader :calls

  def initialize
    @calls = []
  end

  def deliver(to:, body:)
    @calls << { to: to.dup.freeze, body: body.dup.freeze }.freeze
    :queued
  end
end

class TestDoubles < Minitest::Test
  def test_struct_stub
    price = Struct.new(:cents).new(1200)
    assert_equal 1200, price.cents
  end

  def test_singleton_override
    message = String.new('my object')
    def message.to_s
      'mocking ' + super
    end

    assert_equal 'mocking my object', message.to_s
    assert_equal 'untouched', String.new('untouched').to_s
  end

  def test_checks_inside_a_double
    mailer = Object.new
    check = method(:assert_equal)
    mailer.define_singleton_method(:deliver) do |to:, body:|
      check.call('reader@example.test', to)
      check.call('Received 1200 cents.', body)
      :queued
    end

    result = ReceiptSender.new(mailer).call(
      to: 'reader@example.test', amount_cents: 1200
    )
    assert_equal :queued, result
  end

  def test_spy_records_the_boundary_call
    mailer = RecordingMailer.new
    result = ReceiptSender.new(mailer).call(
      to: 'reader@example.test', amount_cents: 1200
    )

    assert_equal :queued, result
    assert_equal [
      { to: 'reader@example.test', body: 'Received 1200 cents.' }
    ], mailer.calls
  end

  def test_spy_assertion_catches_missing_and_duplicate_delivery
    expected = [{ to: 'reader@example.test', body: 'Received 1200 cents.' }]
    mailer = RecordingMailer.new

    # No call happened. The final assertion must reject this history.
    assert_raises(Minitest::Assertion) { assert_equal expected, mailer.calls }

    sender = ReceiptSender.new(mailer)
    2.times { sender.call(to: 'reader@example.test', amount_cents: 1200) }
    assert_equal 2, mailer.calls.length
    assert_raises(Minitest::Assertion) { assert_equal expected, mailer.calls }
  end

  def test_spy_snapshots_its_string_arguments
    mailer = RecordingMailer.new
    recipient = String.new('reader@example.test')
    body = String.new('Original body')
    mailer.deliver(to: recipient, body: body)
    recipient.replace('changed@example.test')
    body.replace('Changed body')

    assert_equal [
      { to: 'reader@example.test', body: 'Original body' }
    ], mailer.calls
  end

  def test_mock_expectation
    mailer = Minitest::Mock.new
    mailer.expect(:deliver, :queued, [],
                  to: 'reader@example.test', body: 'Received 1200 cents.')

    result = ReceiptSender.new(mailer).call(
      to: 'reader@example.test', amount_cents: 1200
    )
    assert_equal :queued, result
    assert mailer.verify
  end

  def test_mock_rejects_missing_wrong_and_excess_calls
    missing = Minitest::Mock.new
    missing.expect(:deliver, :queued, [], to: 'reader@example.test', body: 'Receipt')
    assert_raises(MockExpectationError) { missing.verify }

    wrong = Minitest::Mock.new
    wrong.expect(:deliver, :queued, [], to: 'reader@example.test', body: 'Receipt')
    assert_raises(MockExpectationError) do
      wrong.deliver(to: 'other@example.test', body: 'Receipt')
    end

    duplicate = Minitest::Mock.new
    duplicate.expect(:deliver, :queued, [], to: 'reader@example.test', body: 'Receipt')
    duplicate.deliver(to: 'reader@example.test', body: 'Receipt')
    assert_raises(MockExpectationError) do
      duplicate.deliver(to: 'reader@example.test', body: 'Receipt')
    end
  end

  def test_scoped_stub_restores_the_method_after_an_exception
    message = String.new('original')
    assert_raises(RuntimeError) do
      message.stub(:to_s, 'temporary') do
        assert_equal 'temporary', message.to_s
        raise 'interrupted'
      end
    end
    assert_equal 'original', message.to_s
  end
end

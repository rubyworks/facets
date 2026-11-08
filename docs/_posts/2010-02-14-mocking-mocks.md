---
title: Mocking Mocks
date: 2010-02-14
---

Ruby has a surprisingly good test-double kit built right into its object
model. We can make a little object that returns a prepared answer, add a
method to one particular instance, or record the messages sent to a
collaborator. None of that requires inventing a new language for our tests.

That isn't a reason to throw out mocking libraries. It is a good reason to
understand how little machinery the ordinary cases actually need. Let's
start small and work our way up.

The assertions below belong inside a `Minitest::Test` method. The
[complete runnable example](../examples/mocking-mocks/test_doubles.rb)
puts them together and includes the failure cases as well.

## An object with an answer

A *stub* supplies a prepared response. If all we need is an object with a
`cents` method, Ruby's
[`Struct`](https://docs.ruby-lang.org/en/3.4/Struct.html) makes one for us:

```ruby
price = Struct.new(:cents).new(1200)
assert_equal 1200, price.cents
```

And because `Struct.new` returns a class, we can name it and reuse it when
that becomes useful. For one tiny test, the anonymous class may be plenty.

Sometimes we already have the object and want to change just one method.
Singleton methods make that equally straightforward:

```ruby
message = String.new('my object')
def message.to_s
  'mocking ' + super
end

assert_equal 'mocking my object', message.to_s
assert_equal 'untouched', String.new('untouched').to_s
```

The new method belongs to this particular string. `super` still reaches the
ordinary implementation. We're using a fresh object here, so there is no
shared method to restore when the test finishes.

If we do replace a method on a shared object, cleanup matters. A failed test
must not leave its replacement installed for the next test. A block-scoped
stub supplied by a testing library can handle that restoration for us; the
runnable example checks that it happens even when the block raises.

## Checking a call as it happens

Let's give our doubles a small job. This class asks a mailer to send a receipt:

```ruby
class ReceiptSender
  def initialize(mailer)
    @mailer = mailer
  end

  def call(to:, amount_cents:)
    @mailer.deliver(to: to, body: "Received #{amount_cents} cents.")
  end
end
```

The mailer is passed in, so the test can supply a substitute without changing
any global mail service or sending actual email. Its boundary is a single
method, `deliver`, with two keyword arguments.

We could check those arguments directly inside the replacement method:

```ruby
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
```

`define_singleton_method` keeps access to the local `check` variable, which
holds the test's assertion method. A wrong recipient or body fails an
assertion as soon as `deliver` is called.

Pretty easy. But there is a hole: **if `deliver` is never called, neither
assertion runs.** The result assertion helps here, but it does not establish
that a message was sent. A broken sender could simply return `:queued`.

A check inside a method can judge a call it receives. It cannot, on its own,
notice the absence of that call. For that, we need to inspect what happened
after the sender has finished.

## A stub that remembers

A *spy* records calls so the test can inspect them afterward. We don't need
a universal message-forwarding proxy to make one. For this interface, an
ordinary class will do:

```ruby
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
```

The two string arguments are copied and frozen when recorded. Otherwise a
caller could mutate a string later and accidentally rewrite the history of
an earlier call. This is a snapshot for this specific interface, not a
universal scheme for copying arbitrary object graphs.

Now the test can inspect the record:

```ruby
mailer = RecordingMailer.new
result = ReceiptSender.new(mailer).call(
  to: 'reader@example.test', amount_cents: 1200
)

assert_equal :queued, result
assert_equal [
  { to: 'reader@example.test', body: 'Received 1200 cents.' }
], mailer.calls
```

That one comparison checks the recipient, the body, and the fact that there
was exactly one delivery. No calls produces an empty list. Two calls
produces two entries. Both fail the assertion.

The spy is also a stub: it returns `:queued`. The names describe jobs a test
double performs; they needn't be mutually exclusive kinds of object.

There is still an important limit. This test checks that `ReceiptSender`
asked the mailer to deliver. It doesn't check that a real mail adapter speaks
the right protocol, handles a rejected message, or reaches a recipient.
Those belong in tests of the adapter and, where appropriate, integration
tests. Replacing a collaborator doesn't establish that the real one works.

## An expectation declared in advance

For a *mock*, we specify an expected interaction before running the code,
then verify that it occurred. We could build that check around our recording
mailer. But this is also where an existing library starts earning its keep.

Here is the same test using
[`Minitest::Mock`](https://ruby-doc.org/3.4/gems/minitest/Minitest/Mock.html)
from Minitest 5:

```ruby
mailer = Minitest::Mock.new
mailer.expect(:deliver, :queued, [],
              to: 'reader@example.test', body: 'Received 1200 cents.')

result = ReceiptSender.new(mailer).call(
  to: 'reader@example.test', amount_cents: 1200
)
assert_equal :queued, result
assert mailer.verify
```

The expectation says that `deliver` must be called once with those keyword
arguments and should return `:queued`. The empty array specifies that no
positional arguments are expected.

A wrong argument or an extra call is rejected when it happens. The final
`verify` catches the call that never happened. Forget that last step and
we have reopened the very hole we were trying to close.

The runnable example uses Minitest 5.25.4 on Ruby 3.4.9. To install that test
dependency if needed and run the examples:

```sh
gem install minitest -v 5.25.4
ruby test_doubles.rb
```

It selects Minitest 5 and disables runner-plugin discovery so that unrelated
installed test plugins don't affect the standalone demonstration. The nine
tests cover the examples above, missing and duplicate deliveries, wrong
arguments, mutable call arguments, and restoration after a stubbed block
raises.

## How much machinery is enough?

A small double with an explicit interface can be easier to understand than
an elaborate expectation chain. It can also make a missing dependency
boundary painfully obvious: if replacing a mailer requires patching half
the application, perhaps the testing syntax isn't the real problem.

On the other hand, a growing collection of homemade expectations, argument
matchers, call-order rules, and cleanup hooks is a mocking library in the
making. At that point, using a maintained one may save quite a bit of work.
An explicit double can also drift from the real interface, so keep that
contract checked rather than assuming a passing isolated test is enough.

The useful question is what the test needs to observe. A prepared answer?
Use a stub. A record of what happened? Add a spy. An interaction that must
occur? Verify it explicitly. Assert the boundary behavior the application
actually depends on, and leave its private choreography alone.

Ruby makes the small cases wonderfully small. We might as well enjoy that
before reaching for the big box of machinery.

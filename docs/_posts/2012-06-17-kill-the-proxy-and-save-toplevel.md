---
title: Kill the Proxy and Save Toplevel
date: 2012-06-17
---

Ruby's top level is an odd place. It looks like a convenient place to write
a little program, but it also participates in the behavior of objects
throughout that program. For ordinary scripts, this is often useful. For a
library that wants to host a small scripting language, it deserves a closer
look.

Ask Ruby what object is receiving calls at the top level:

```ruby
self        # => main
self.class  # => Object
```

That `main` is a particular object. It isn't the `Object` class, and it
isn't a module representing our script. Yet a plain method definition here
lands in `Object`:

```ruby
def greeting
  'hello'
end

method(:greeting).owner == Object
# => true

Object.private_instance_methods(false).include?(:greeting)
# => true

Object.new.send(:greeting)
# => "hello"
```

The method is private, but objects inheriting from `Object` can still call
it internally. A helper defined for the script has become an inherited
method available far beyond the script's apparent boundary.

That is the behavior I want to question. Defining a top-level helper is
perfectly reasonable Ruby. It also has a wider effect than someone writing
an application-specific script might expect.

## The receiver and the definition target

Current Ruby supports dynamic top-level definitions too. On Ruby 3.4, this
works:

```ruby
define_method(:dynamic_greeting) { 'dynamic hello' }
Object.new.send(:dynamic_greeting)
# => "dynamic hello"
```

The interesting distinction is where such definitions belong, rather than
whether a particular helper exists. `main` is still the receiver while
`Object` receives the new instance method.

A small declaration helper makes that difference visible:

```ruby
module Declarations
  def field(name)
    declared_on = self
    define_method(name) { declared_on }
  end
end

class Record
  extend Declarations
  field :declaration_context
end

Record.new.declaration_context == Record
# => true
```

In the class body, the object receiving `field` is the class that gets the
new instance method. Now try the same declaration at the top level:

```ruby
top = self
extend Declarations
field :top_context

Object.new.send(:top_context).equal?(top)
# => true

top.equal?(Object)
# => false
```

We captured `main`, while the method was defined on `Object`. Nothing
mysterious happened once the rules were understood. But a reusable DSL
cannot assume its declaration receiver and definition target are identical
in these two contexts.

That is what I mean by the proxy problem: the top level offers conveniences
for working with another definition context, while remaining a distinct
object with its own identity. It isn't a general-purpose module namespace.

## Give the script a namespace

My preferred alternative is to make the script's top level a self-extended
module. Written explicitly in ordinary Ruby, that looks like this:

```ruby
module MAIN
  extend self

  def namespaced_greeting
    'hello from MAIN'
  end

  define_method(:namespaced_dynamic) { 'dynamic MAIN' }
end

MAIN.namespaced_greeting
# => "hello from MAIN"
```

The definitions now belong to a module we can inspect and use deliberately.
They don't become methods on every ordinary object merely because we wrote
a helper for our script. If a class does need the behavior, inclusion can
make that choice explicit:

```ruby
class Consumer
  include MAIN
end

Consumer.new.namespaced_greeting
# => "hello from MAIN"
```

This doesn't abolish the distinction between module and instance calls.
A method called through `MAIN` receives `MAIN` as `self`; the same method
included in `Consumer` receives a consumer instance. Shared state and
receiver assumptions still require thought. The benefit is an explicit
boundary for the definitions.

## A loader can choose this policy today

We don't need a language change to give one application's scripts a module
context. A small loader can create it, install its declaration interface,
and evaluate a trusted script there:

```ruby
module SettingsDSL
  def option(name, default)
    define_method(name) { default }
  end
end

module ScriptLoader
  def self.load(source, filename = 'settings.rb')
    context = Module.new
    context.extend(context)
    context.extend(SettingsDSL)
    context.module_eval(source, filename, 1)
    context
  end
end

```

Here is a script and the resulting interface:

```ruby
settings = ScriptLoader.load(<<~RUBY)
  option :port, 8080
  def label
    "demo"
  end
RUBY

settings.port   # => 8080
settings.label  # => "demo"
```

The string form of
[`module_eval`](https://docs.ruby-lang.org/en/3.4/Module.html#method-i-module_eval)
evaluates these definitions in the new module. Extending that module with
itself makes its instance methods callable through the module object as
well. The filename and line number help identify errors in the evaluated
source. Each load creates a separate context, so another script can define
its own `port` without replacing this one.

This gives the application a namespace policy, not a security sandbox.
The evaluated Ruby can still access files, globals, and other objects.
Nor does it make `require` automatically load additional scripts into the
same context. A real loader must decide how imports and shared definitions
work. Those are part of the design rather than details a wrapper can wish
away.

The [runnable namespace examples](../examples/toplevel/namespaces.rb) check
the definition targets, captured receivers, explicit inclusion, and separate
loader contexts on Ruby 3.4.9. They can be run in their own process with:

```sh
ruby namespaces.rb
```

## Changing Ruby's default would be a larger decision

The explicit module is a working technique. Making it the language's default
top level is a proposal with compatibility costs. Existing scripts expect
top-level methods to become private `Object` methods. Replacing that rule
would change lookup and could break code that relies on it.

A default `MAIN` would also need a clear identity: one module per file, per
application, or per loader? Where should constants go? What would a required
file share with its caller? Those questions need answers before an appealing
snippet becomes a coherent language design.

I still like the direction. A script's helpers ought to have an obvious
home, and an application's DSL ought to be able to choose its reach. A
self-extended module provides that home today when we use it explicitly.
Whether Ruby should make that the default is the more interesting argument
than whether we can add one more convenience method to `main`.

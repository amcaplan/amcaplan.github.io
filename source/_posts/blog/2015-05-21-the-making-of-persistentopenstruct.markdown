---
layout: post
title: "The Making of PersistentOpenStruct"
date: 2015-05-21 03:39:23 +0300
comments: true
categories:
- blog
- gems
- Ruby
twitter:
  description: Motivating factors behind the gem, and how it works
---

So I built this thing...

## The Challenge

Here's the problem we were having at work.  We have a bunch of microservices
which communicate with each other via HTTP.  Since they're passing around raw
data, and the shape often changes, we decided quite some time ago to use classes
inheriting from `OpenStruct`, that magical schema-free class, as a data container.

The problem is, `OpenStruct` is also ridiculously slow...

<!-- more -->

``` ruby
[1] pry(main)> require 'ostruct'
=> true
[2] pry(main)> require 'benchmark/ips'
=> true
[3] pry(main)> Benchmark.ips do |x|
[3] pry(main)*   class RegularClass
[3] pry(main)*     attr_accessor :foo
[3] pry(main)*   end
[3] pry(main)*
[3] pry(main)*   class OpenStructClass < OpenStruct
[3] pry(main)*   end
[3] pry(main)*
[3] pry(main)*   x.report('regular class') do
[3] pry(main)*     r = RegularClass.new
[3] pry(main)*     r.foo = :bar
[3] pry(main)*     r.foo
[3] pry(main)*   end
[3] pry(main)*
[3] pry(main)*   x.report('OpenStruct class') do
[3] pry(main)*     o = OpenStructClass.new
[3] pry(main)*     o.foo = :bar
[3] pry(main)*     o.foo
[3] pry(main)*   end
[3] pry(main)* end
Calculating -------------------------------------
       regular class   114.702k i/100ms
    OpenStruct class    14.400k i/100ms
-------------------------------------------------
       regular class      3.901M (± 4.0%) i/s -     19.499M
    OpenStruct class    158.799k (± 7.1%) i/s -    792.000k
```

From that benchmark, it seems like `OpenStruct` is 4% the speed of a regular
class - not particularly helpful when performance is a significant concern.

In our case, profiling with `StackProf` showed that `OpenStruct` was taking up
13% of CPU time in many cases; in short, it was one of our worst offenders,
performance-wise.

However, we really wanted to stick with `OpenStruct` because of the flexibility
it provides.  How could we bridge that gap?

## Attempt 1: OpenFastStruct

I had read about a gem called `open_fast_struct` recently, which provides a
different implementation of `OpenStruct`, with its own performance quirks.  In
most use cases, it outperforms `OpenStruct` by a factor of 4.  It achieves this
by skipping a step that `OpenStruct` does.

Internally, every time I call a new method on and `OpenStruct` instance, it
defines a new method for next time.  This is much more efficient if I'm going to
be calling that method hundreds of times.  However, if I'm just calling it a few
times, it's not worth it to define the method, and instead what I should really
do is continue to rely on `#method_missing`.

That idea is at the core of `OpenFastStruct`.  It just maintains an internal
hash containing the data you insert, and any call to `#method_missing` interacts
with that hash.  In contrast, `OpenStruct` also maintains an internal hash, but
defines methods on-the-fly to interact with that hash.

However, `OpenFastStruct` doesn't maintain the entire public interface of
`OpenStruct`, and it became clear we would need to monkey-patch it quite a bit
to get it to work for us.

Additionally, I realized that we didn't really need _all_ the flexibility of
`OpenStruct`.  Instead, our needs would be best served by something that would
define the shape of the class on-the-fly and then stick with it.

## Attempt 2: PersistentOpenStruct

So I decided to build a new gem.  `PersistentOpenStruct`, as the name suggests,
allows the construction of a class on-the-fly.  The major difference from
`OpenStruct` is that it defines methods on the class, rather than defining
singleton methods on the object.  This means that if I create 1,000 objects with
the same 8 properties, `OpenStruct` will define 8,000 methods, and
`PersistentOpenStruct` will define 8.

To make sure I obeyed the entire public interface, I decided to put this
together by subclassing `OpenStruct` and redefining the methods which would
otherwise define singleton methods.  This has the nice benefit that the entire
significant code in the gem is around 15 lines.  The downside is, of course,
that `PersistentOpenStruct` can only be understood in the context of
`OpenStruct` and depends on the internals of `OpenStruct`.  Still, I think the
tradeoffs are in favor of keeping things simple for now, and letting things
develop over time as needed.

The other thing I did was literally copy over the tests that are used to test
the original `OpenStruct` class.  The only changes I made were adjustments which
made sense in this case (unlike `OpenStruct`, what happens to one object affects
the `#respond_to?` answer of another), and adding some additional tests.

Enough of my chitchat, though, it's time for the results!

## PersistentOpenStruct Revealed

Here's some code which demonstrates how `PersistentOpenStruct` works.

``` ruby
class MyDataStructure < PersistentOpenStruct
end

datum1 = MyDataStructure.new(foo: :bar)

datum2 = MyDataStructure.new
datum2.respond_to?(:baz) #=> false
datum2.respond_to?(:foo) #=> true
```

Since `datum1` used `foo` as a key, every instance of `MyDataStructure` will
now have a `foo` method.  Again, this happens because `MyDataStructure` has the
`#foo=` and `foo` methods defined on the class as soon as any instance gets a
`foo` property.

As for performance?  You can download the gem and run the benchmarks yourself.
Various actions (key/value assignment on initialization, key/value assignment
after initialization, value access) have different comparisons, but generally
speaking, `PersistentOpenStruct` is about 25%-99% as fast as a regular class.

You can see the results I got on my Mac at the gem's homepage.

## The Bottom Line

By simply dropping in `PersistentOpenStruct` in place of `OpenStruct`, we saw a
10% reduction in response time for Sidekiq jobs that relied heavily on
`OpenStruct`s.

Sound interesting?  Check out
[the gem's homepage](http://github.com/amcaplan/persistent_open_struct) and give
it a whirl.  Drop me a line - leave a comment or submit a GitHub issue - let me
know what happens!

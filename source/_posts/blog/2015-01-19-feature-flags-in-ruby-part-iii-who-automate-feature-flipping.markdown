---
layout: post
title: "Feature Flags in Ruby, Part III: Who? (Automate Feature Flipping)"
date: 2015-01-19 16:49:19 -0500
comments: true
categories:
- blog
twitter:
  description: A primer on the use of James Golick's `degrade` gem to automate feature flipping.
---

*Note: Part III assumes familiarity with the idea of feature flags, and their
practical implementation using the [rollout gem] [rollout].  For the
theoretical background, see [Part I] [feature flags part 1].  For more info
about rollout, see [Part II] [feature flags part 2].*

You have feature flags in your application, letting you turn off calls to
external services as necessary.  How can we make this happen automatically?

<!-- more -->

## Degrade: An Amputation Tool

[Degrade] [degrade] exists to cut off error-prone external services when they
fail.  Let's go through a demo of how we might use it.

Before starting, we should note that redis is absolutely required to use
degrade.

### Install the gem
First, `gem install degrade` or add `gem "degrade"` to your Gemfile and `bundle
install`.

### Instantiate the `degrade` object
Next, assuming you have a `redis` variable which is an instance of
[Redis] [redis gem]:

``` ruby
degrade_my_feature = Degrade.new(
  redis,
  name:             :my_feature,
  sample:           5000, # The sample is reset after this number of requests.
  minimum:          100,  # Degrade won't check whether the threshold has been hit until this number of requests has been made.
  threshold:        0.1,  # The error rate (in this case, 10%) to deactivate the service
  errors:           [StandardError], # The errors which will label this request as a failure
  failure_strategy: -> {  # A lambda to be called when the error rate is reached
    rollout.deactivate(:my_feature)
  }
)
```

Whoa, that's a lot of options!  Most pieces are optional and should be
fine-tuned to the needs of your application.  The important things are: you need
to pass in a `redis` object, give your degrade object a `name`, and feed it a
`failure_strategy` lambda which will run if the error threshold is reached.

Let's discuss how to use your shiny new degrade object!

### Wrap a call

Your `degrade` object comes with a `#perform` method that takes a block, thusly:

```ruby
data = degrade_my_feature.perform do
  Net::HTTP.get('mega-downtime.com', '/data.json')
end
```

It will run the block without impacting the return value, only pausing to mark
whether the block raised one of the specified errors.  As you can see from
[the source code] [degrade#perform source code] for `#perform`:

``` ruby
def perform
  begin
    mark_request
    yield
  rescue *@errors => e
    mark_failure
    raise e
  end
end
```

It simply marks that a request is being made, and yields to your passed-in
block. If all goes well, `perform` will return the return value of the block.
If an error occurs, and it's one of the errors you've selected to track, degrade
will rescue, mark that this request ended in failure, and re-raise the error.

It's important to understand that degrade won't automatically turn off a feature
for you.  All it does is run the `failure_strategy` you've given it.  You can
use something like rollout to handle the failure situation.  Here is an example:

``` ruby
if rollout.active?(:my_feature)
  data = degrade_my_feature.perform do
    Net::HTTP.get('mega-downtime.com', '/data.json')
  end
  hashify(data)
else
  {}
end
```

You can, of course, cut off the request earlier in your code.  You might turn
off a controller action entirely if the external service it needs is down.

## Customizing Your `failure_strategy`
The `failure_strategy` you pass to degrade is just a plain old lambda, so you
can pass in any code that you want.  Let's say you create an `OutageNotifier`
module which can send an email/text when the external service goes down.  Just
call that code from the `failure_strategy`.  You can also set up a Sidekiq
worker that will reactivate the service (i.e., try again) after a specified
period of time.

Here's how you might do all that in one `failure_strategy`:

```ruby
degrade_my_feature = Degrade.new(
  redis,
  name: :my_feature,
  failure_strategy: -> {
    rollout.deactivate(:my_feature)
    OutageNotifier.notify(downtime: :my_feature)
    MyFeatureActivatorWorker.perform_in(30.minutes)
  }
)
```

### Reactivation
There is one catch to be aware of when reactivating.  Degrade does not
automatically reset the sample when it runs the `failure_strategy`.  It has a
private method to do that (after it hits the sample size max), but we'll respect
that method's privacy.  Here's what [that method] [degrade reset sample] looks
like:

```ruby
def reset_sample
  if requests > @sample
    @redis.del(requests_key)
    @redis.del(failures_key)
  end
end
```

If we [dive deeper] [degrade keys], we'll see that `requests_key` and
`failures_key` are:

```ruby
def requests_key
  "status:#{@name}:requests"
end

def failures_key
  "status:#{@name}:failures"
end
```

So if we copy those methods, all we have to do to reset the sample is copy that
code into our worker.  Here's a simplified Sidekiq worker, where `#perform` will
reset the sample and then reactivate the feature flag:

```ruby
class MyFeatureActivatorWorker
  include Sidekiq::Worker

  def perform
    reset_sample
    rollout.activate(:my_feature)
  end

  private

  def reset_sample
    redis.del(requests_key)
    redis.del(failures_key)
  end

  def requests_key
    "status:my_feature:requests"
  end

  def failures_key
    "status:my_feature:failures"
  end
end
```

Now you can use the line of code:
```ruby
MyFeatureActivatorWorker.perform_in(30.minutes)
```
to reactivate the feature after a 30-minute delay.  If you're really clever, you
can even set it up to increase the delay each time.  It all depends on the needs
of your application.

## Wrapping Up
In this series, we've learned

- what feature flags are

- how to use feature flags with the rollout gem

- how to use degrade, building on rollout, to shut off external services as
necessary

Let me know about your experiences in the comments!

***

*Recently I gave a [talk] [nyc.rb talk] at [NYC.rb] [nyc.rb] about
[James Golick] [james golick]'s `rollout` and `degrade` gems.  These posts are a
rehash and expansion of the material delivered there.*

*To learn more about James's life and the circumstances surrounding his untimely
passing, see the links below the [SpeakerDeck][SpeakerDeck].*

[rollout]: https://github.com/FetLife/rollout
[degrade]: https://github.com/jamesgolick/degrade

[feature flags part 1]: /blog/2015/01/18/feature-flags-in-ruby-part-i-what-and-why/
[feature flags part 2]: /blog/2015/01/18/feature-flags-in-ruby-part-ii-how-and-where/

[redis gem]: https://github.com/redis/redis-rb

[degrade#perform source code]: https://github.com/jamesgolick/degrade/blob/master/lib/degrade.rb#L12-L20
[degrade reset sample]: https://github.com/jamesgolick/degrade/blob/master/lib/degrade.rb#L56-L61
[degrade keys]: https://github.com/jamesgolick/degrade/blob/master/lib/degrade.rb#L31-L37

[nyc.rb talk]: /talks/2015/01/14/flag-your-features-with-rollout-and-degrade
[nyc.rb]: http://www.meetup.com/NYC-rb/
[james golick]: http://jamesgolick.com
[SpeakerDeck]: https://speakerdeck.com/amcaplan/flag-your-features-with-rollout-and-degrade
[Vitals]: http://vitals.com

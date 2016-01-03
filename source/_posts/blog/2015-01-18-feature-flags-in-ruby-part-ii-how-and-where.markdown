---
layout: post
title: "Feature Flags in Ruby, Part II: How and Where"
date: 2015-01-18 22:16:18 -0500
comments: true
categories:
- blog
- feature flags
twitter:
  description: How to integrate James Golick's `rollout` gem into your app, and some clever ways to interact with it.
---

*Note: Part II assumes familiarity with the idea of feature flags.  For the
theoretical background, see [Part I] [feature flags part 1].*

Alright, you're convinced that feature flags are a necessary tool for your app.
Let's discuss a gem, created by the late [James Golick] [james golick], which
make the process of feature flagging as simple as could be.

<!-- more -->

## Rollout: A Feature Flagging Tool
[Rollout] [rollout] is a super-simple gem for feature flagging. To get started,
you'll need a redis instance accessible to your app.  You likely have this in
place already.  If not, you can pass in a reference to any object that accepts
`set` and `get` methods.  But as redis is becoming a more and more common part
of the standard stack, you should probably just set up a redis instance.

Now let's get started.

### Install the gem
First, you'll need to `gem install rollout` or add `gem "rollout"` to your
Gemfile and `bundle install`.

### Instantiate the `rollout` object
Next, assuming you have a `redis` variable which is an instance of
[Redis] [redis gem]:

``` ruby
rollout = Rollout.new(redis)
```

and you have your `rollout` object.  The [official docs] [rollout global]
recommend assigning it to a global variable (`$rollout`), but if you'd rather
avoid that, you can assign a `rollout` variable at the global scope.  (In a
Rails app, this code would belong in an initializer.)

### Flipping Switches
Now you get to become a [switch-flipper] [switch-flipper]!  Turning a feature on
or off is as simple as:
``` ruby
# activate for all users
rollout.activate(:chat)

# deactivate for all users
rollout.deactivate(:chat)
```

The rollout object will always be able to tell you whether a feature is active:
``` ruby
rollout.activate(:my_cool_feature)
rollout.active?(:my_cool_feature) #=> true
rollout.deactivate(:my_cool_feature)
rollout.active?(:my_cool_feature) #=> false
```

### Partial Activation

Sometimes you may want to activate a feature for a particular set of
users.  Let's say we want to grant our premium users access to the beta version
of our product.
``` ruby
rollout.define_group(:premium_users) { |user| user.premium? }
rollout.activate_group(:beta, :premium_users)

premium_user = User.where(premium: true).first
rollout.active?(:beta, premium_user) #=> true

regular_user = User.where(premium: false).first
rollout.active?(:beta, regular_user) #=> false
```
Rollout knows that only `premium_users`, as defined by the block
`{ |user| user.premium? }`, have the `beta` feature active, and will return true
or false based on the user passed in to `#active?`.

Sometimes you may want to activate a feature for a random percentage of users.
Rollout can handle that too:

```ruby
rollout.activate_percentage(:chat, 20)
```

Now 20% of users will have chat activated.  Rollout also makes sure that it's
the same set of 20% of users who have chat available, so users don't have a
disjointed experience.

### Inserting Branch Points

The trickiest part of using feature flags is figuring out where to branch your
code.  Ideally, the code should only need one call to `rollout#active?` to
invoke the correct behavior.

#### Controller-Level Branch Points

Sometimes, the simplest place to branch is in a controller.  Let's say we want
to feature-flag an entire endpoint in a Rails app:

```ruby
class ExperimentalController < ApplicationController

  def index
    if rollout.active?(:my_feature)
      @entities = MyFeature.get_entities(params)
      respond_with @entities
    else
      head(:service_unavailable)
    end
  end

end
```

If `my_feature` is active, the controller does its usual work of calling models
and views.  If `my_feature` is deactivated, the controller responds with a
[503] [503].
This is a pretty clean example of an ["On/Off" feature flag][feature flag type].

This pattern is very useful for experimental API endpoints, as well as debugging
utilities which will often be inactive.  It is also a good place to halt
requests which, to succeed, will require a call to an external service that is
currently experiencing downtime.

#### Model-Level Branch Points

Sometimes we want our application to display fundamentally different behavior
depending on the situation.

In this sample scenario, we already have a GitHub API integration, and we're
trying out a BitBucket API integration as well.  When we fetch the user's repos,
we want to control at runtime whether we're just getting the GitHub repos or
also checking BitBucket.  Here's the code:

```ruby
class User
  # ...

  def repos
    if rollout.active?(:bitbucket)
      github_repos + bitbucket_repos
    else
      github_repos
    end
  end

  # ...
end
```

It might take hundreds of lines of code across multiple classes to fetch and
format those `bitbucket_repos` for the User, but we found one point in our code
where we can decide whether or not all that code gets executed.

#### View/Decorator-Level Branch Points

Placing feature-related conditionals in our views is (almost) always a bad
practice, so let's not address it here.  But we can sometimes make the case that
a decorator class is the right place for a feature flag.

Let's say that our API currently returns a top-level JSON Array, which is a
[Bad Practice™] [JSON arrays].  We want to follow the Good Practice and return
a top-level JavaScript object.  But we realize that clients may not be ready to
handle that.  We can set up a feature flag to switch over to the new format once
our clients have had ample time to prepare:

```ruby
class ResponseFormatter

  attr_reader :array

  def initialize(array)
    @array = array
  end

  def output
    if rollout.active?(:safe_json_format)
      { 'array' => array }
    else
      array
    end
  end

end
```

This is a very clear example of a [This/That feature flag] [feature flag type].

## Back to Flipping Switches

We've spoken about how to set up switches, and how to flip them in code.  How do
we flip the switches when our code is running live in production?

Unfortunately, the rollout gem doesn't provide any sort of UI, and you basically
need to SSH into your production server and modify the value in redis.  In the
case of Rails, you would enter the Rails console, and execute the command
`rollout.activate(:my_feature)` or `rollout.deactivate(:my_feature)`.

Is there a better way?

### Improvement 1: Set Up an HTTP Endpoint

If we're running web apps, we can always add endpoints!  This is how a Rails app
might handle feature flipping via HTTP requests:

``` ruby
class FeaturesController < ApplicationController

  def update
    rollout.activate(params[:id].to_sym)
    head :ok
  end

  def destroy
    rollout.deactivate(params[:id].to_sym)
    head :ok
  end

end

```

You probably want to have a `before_filter` to require authentication as well.

At any rate, this allows you to easily activate and deactivate features without
needing to SSH anywhere.

### Improvement 2: Use Hubot

Hubot comes with a simple, powerful system for making HTTP requests.  Using this
system, you can set up Hubot to hit these endpoints when instructed via chat
command.  If you have a running Hubot instance, it's very simple to set up.
This is the code to activate a feature:

``` coffeescript
robot.respond /activate (\w+)$/i, (msg) ->
  feature = msg.match[1]

  msg.http("http://my-app.com/features/#{feature}").put() ->
    msg.reply "Activated #{feature}!"
```

Now, when I say `hubot activate a_feature`, it takes care of it, then responds,
`Activated a_feature!`  Suddenly, managing feature flags becomes a breeze.

## Wrapping Up
We've discovered how to use rollout to easily turn bits of code on and off in a
live application.  In [Part III] [feature flags part 3], we will discuss how to
automatically turn off feature flags when an external service experiences
downtime.

***

*Recently I gave a [talk] [nyc.rb talk] at [NYC.rb] [nyc.rb] about
[James Golick] [james golick]'s `rollout` and `degrade` gems.  These posts are a
rehash and expansion of the material delivered there.*

*To learn more about James's life and the circumstances surrounding his untimely
passing, see the links below the [SpeakerDeck][SpeakerDeck].*

[rollout]: https://github.com/FetLife/rollout
[degrade]: https://github.com/jamesgolick/degrade

[feature flags part 1]: /blog/2015/01/18/feature-flags-in-ruby-part-i-what-and-why/
[feature flag type]: /blog/2015/01/18/feature-flags-in-ruby-part-i-what-and-why/#feature-flag-types
[feature flags part 3]: /blog/2015/01/19/feature-flags-in-ruby-part-iii-who-automate-feature-flipping/

[redis gem]: https://github.com/redis/redis-rb
[rollout global]: https://github.com/redis/redis-rb
[switch-flipper]: https://www.youtube.com/watch?v=eb9GREgzQYQ

[503]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.5.4

[JSON arrays]: http://flask.pocoo.org/docs/0.10/security/#json-security

[nyc.rb talk]: /talks/2015/01/14/flag-your-features-with-rollout-and-degrade
[nyc.rb]: http://www.meetup.com/NYC-rb/
[james golick]: http://jamesgolick.com
[SpeakerDeck]: https://speakerdeck.com/amcaplan/flag-your-features-with-rollout-and-degrade
[Vitals]: http://vitals.com

---
layout: post
title: "Feature Flags in Ruby, Part I: What and Why"
date: 2015-01-18 16:07:26 -0500
comments: true
categories:
- blog
---

*Note: Part I will be more theoretical.  If you already know about feature
flags and want to learn about the [rollout] [rollout] and [degrade] [degrade]
gems, check out Part II.*

## What are Feature Flags?
Glad you asked!

Feature flags, also known as "feature flippers," "feature toggles,"
[and more] [wiki feature flags], are a way to simply turn bits of code on and
off in a live, running application.

While we won't get into too many of the details in this post, here's a simple
way to think about it.  Let's say you run a bowling alley.  Most of the time,
it's a straightforward establishment - lanes, balls, scoring computers, shoes...
you get the idea.  However, every Tuesday night you turn over the place, and now
it's Cosmic Bowling night!  You're blasting music, shining blacklights, the
disco ball is spinning... it's a different world.  How are you going to carry
out this operation?

<!-- more -->

Theoretically, you could go around every week and change all the lightbulbs, set
up the disco ball, and hook up the speakers, and then undo it all afterwards.
But that setup is highly error-prone and labor-intensive!

Shockingly, programmers do this all the time.  Sometimes, real-world needs force
us to have 2 working versions of our code.  Maybe we need to be ready to respond
to 2 versions of an API - we'll get into examples shortly.  The way we deal with
this is often by maintaining two active branches of our code.  This means that
we end up having to make sure we're applying all new code and fixes to both
branches, which is a nightmare.  And what if they really diverge to the point
that patches are no longer simple?

What's worse, sometimes we need to go back and forth on code deployed to our
production servers.  Do we really want the stress of deploying code every time
we want a feature turned on or off?  Of course not!

Enter feature flags.

To implement a feature flag, you need 2 things.  First, you need a branch point
in your code where you can decide which direction your program will take.
Second, you need an external method of flipping the switch in one direction or
another.

<a name="feature-flag-types"></a>
## Types of Feature Flags
I haven't seen it described this way anywhere, but I've come up with the idea
that there are two major types of feature flags, which I've named as follows:

1. **On/Off** - decide whether a feature should be active or inactive
2. **This/That** - direct executing code down one of two paths

Although they are implemented in nearly the same way, these two types differ
conceptually, and we will refer to them often as we continue our discussion.

## Why Feature Flags?
Let's jump into some real-world scenarios to understand how feature flags might
be helpful.  I will list 5 types of situations, but there are certainly others,
and you may discover them in your own development work.

### Experimental Code
Maybe you, or someone ordering you around, had a great idea about how to improve
your web app.  But not everyone is convinced that it's such a good idea, or
perhaps someone thinks it might break everything.  You'd like to turn it on for
a bit and see what happens, with a low cost to deactivate the new code if
anything goes wrong.

Using feature flags, you can insert a branch point to decide whether to run the
old code or jump into your new feature.  Then, when the app is live in
production, you can turn on the feature, see what happens, and be able to
quickly deactivate the new code.

A/B testing also falls under this paradigm.  If you are considering a change to
your app and want some evidence about the user impact, you can turn it on,
gather evidence, and then turn it off again while you evaluate.  Or, using a
This/That feature flag, you can test two different implementations and decide
which is better.

### Syncing Apps in an SOA Ecosystem
Your company has jumped on the SOA bandwagon, and your app is now broken up into
multiple services that talk to each other.  Now, you want to change the public
API of one service, which will impact the downstream clients that consume it.
Using feature flags, you can seamlessly transition from one API to the other.

The service being changed has to keep the old code and the new code, and use a
This/That feature flag to control which API version to expose.  The client, in
the meantime, also uses a feature flag to decide which API to consume.  When the
time comes, flip those two switches together, and your apps can communicate
using the new API.  (If you set up your architecture right, you can actually
have both switches really be one switch, which enforces change in unison.)

### Consuming Internal Services (Built by Other Teams)
Although conceptually similar to the previous case, there is an enormous
practical difference.  Your company may have its product split up into services
maintained by separate teams.  In this case, you cannot control exactly when the
other team will change its service.

So let's say you depend on Service X.  Team X tells you they are switching to a
new API in one month's time.  You want to start building against the new API,
to be ready for its deployment, but your code also has to be maintained in the
meantime.  Also, who says they will truly update their API in one month?  Maybe
things will be delayed, and it will be 6 months, during which time your
development progress is stymied by the fact that you can't deploy anything,
since you've built in support for the new API and thereby lost support for the
old!

Feature flags provide a convenient way to handle this issue.  You can build into
your code the ability to access the new API, but keep it inactive using a
feature flag.  Once the new API is in place, flip the switch!

### External Services
Sometimes websites get DoS'ed.  Or DDoS'ed.  Or just a developer did something
dumb and crashed the app for 10 minutes.  Lots of things can happen, and if you
depend on an external service, their downtime can be yours as well.

Luckily, there is a way out.  You can establish a strategy for what to do when
the external service is inaccessible.  Normally, that strategy is kept inactive
using a feature flag.  If the service experiences downtime, toggle the flag and
you can activate your strategy for circumventing the service.  Even better, you
don't have to do it yourself; the next post will show you how to activate this
strategy programmatically.

Less downtime means happier customers means fun and profit!

### Debugging Tools
At [Vitals] [Vitals], we have a number of tools we use to log extra information
about the state of our application and the data it processes, for debugging
purposes.  However, these tools come at a price: they add a small amount of
extra latency to each request.  We only want to activate these debugging tools
as necessary for debugging, and the simplest way to do that is to associate them
with feature flags.  Feature flag on--do extra work.  Feature flag off--speed
up the request.

Additionally, depending on the situation, debugging tools may occasionally yield
output in the HTTP responses sent to the client.  This may be necessary to
invoke on occasion, but certainly should not be active as a default.  It might
expose too much information to users, and certainly should not be active by
default.  Perhaps you want to have this information available as a matter of
course in your QA/UAT/staging environment, and in case of emergency in
production.  In any of these cases, feature flags provide convenient,
finely-tuned control over these sensitive parts of your application.

## Wrapping Up
At this point, we have a better understanding of what feature flags are, and why
we might want them in our application.  In Part II, we will give practical
examples of how to set up feature flags, and where to place them in our code.

***

*Recently I gave a [talk] [nyc.rb talk] at [NYC.rb] [nyc.rb] about
[James Golick] [james golick]'s `rollout` and `degrade` gems.  These posts are a
rehash and expansion of the material delivered there.*

*To learn more about James's life and the circumstances surrounding his untimely
passing, see the links below the [SpeakerDeck][SpeakerDeck].*

[rollout]: https://github.com/FetLife/rollout
[degrade]: https://github.com/jamesgolick/degrade
[wiki feature flags]: http://en.wikipedia.org/wiki/Feature_toggle

[nyc.rb talk]: /talks/2015/01/14/flag-your-features-with-rollout-and-degrade
[nyc.rb]: http://www.meetup.com/NYC-rb/
[james golick]: http://jamesgolick.com
[SpeakerDeck]: https://speakerdeck.com/amcaplan/flag-your-features-with-rollout-and-degrade
[Vitals]: http://vitals.com
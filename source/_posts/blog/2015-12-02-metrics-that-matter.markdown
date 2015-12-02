---
layout: post
title: "Metrics That Matter"
date: 2015-12-02 16:05:35 +0200
comments: true
categories:
- blog
twitter:
  description: Metrics for developers often get a bad rap. Is the problem the
    metrics themselves, or what they try to quantify?
---

Many of us are familiar with the standard tirades against the use of metrics in
judging developers.  Most of these arguments basically boil down to one of two
concerns:

1. Metrics tend to value things which shouldn't be valued
1. Metrics attempt to quantify things that fundamentally elude quantification

Examples of the first may be measuring lines of code (which rewards overly
verbose, unmaintainable solutions) or test coverage (which encourages test suite
bloat and doesn't ensure good testing practices).  The second applies to metrics
like story points completed (which attempts to quantify productivity as story
points - a bad measure of accomplishment - per time, and encourages high
estimates and rush jobs).

While these points are true, I would argue that there's a bigger issue here.
We should judge the utility of metrics by the results they incentivize.  These
metrics are meant to encourage individual performance, but from a company's
perspective, the goal should be total performance as a team.

<!-- more -->

### How Does An Ideal Team Behave?

If we want to encourage teams to work together and successfully create value, we
would be well advised to consider what we actually care about in a team.

I consider the following team attributes to be most significant:

1. **Sharing** - amassing and spreading knowledge in a manner that benefits the
whole, rather than one particular team member
1. **Communication** - both amongst developers and interacting with other interested
parties (UX, product owners/managers, QA, clients, etc.)
1. **Code Quality** - in terms of both clarity/communicativeness of the code and
number of regressions
1. **Creativity** - going above and beyond handed-down requirements to consider what
is really best for the product, being involved in the design process
1. **Efficiency** - producing solutions at a pace that matches their capacity

Let's consider metrics that best incentivize those goals.

### Sharing

The team should be sure to avoid islands of knowledge, where only one or two
developers are capable of working on a particular area of the product.

One metric often discussed in this vein is the Bus Factor, a measurement of how
many developers would need to get hit by a bus to immobilize the team.  This is
useful in terms of understanding which pieces of the app represent knowledge
gaps amongst the team.

There is another metric I would like to introduce; I call it the Minimum
Familiarity Factor.  The question is: What is the minimum percentage of your
code with which the least experienced developer on your team is familiar?  This
metric complements the Bus Factor, by shifting the focus back to the developers
themselves.  Have any developers been siloed into one specific area of your
ecosystem?  If so, perhaps they could do their job more effectively with
exposure to more of your company's codebase(s).  (Note: The obvious exception
here would be new hires.  In that case, the usual questions of onboarding
methodology are more appropriate trains of thought.)

### Communication

This one is hard to quantify, right?  Well, luckily, quantification isn't the
point.  What metric might we use to incentivize communication?

One thing we might look at is how often developers are pairing.  I don't think
pairing is right for every situation (and Kent Beck
[agrees][Kent Beck on pairing].)  It often conflicts with another core
principle, efficiency.  But I don't think there is a more effective way to
ensure communication between developers than having to code together.  If the
solution is going to be complex, and/or the problem space is unfamiliar to one
or both developers, the payoff is tremendous.

How about communication between developers and other interested parties?  I
don't have a great way of measuring that it's happening.  But there is a point
where it becomes clear that it's not happening.  That point is when stories move
from an advanced stage back to development because the requirements were unclear
the first time around.  Maybe the person who wrote up the story did a terrible
job and just wrote the wrong thing.  Or maybe the requirements were
insufficiently clarified.  In the latter case, the developer should have taken
the time to clarify the situation, rather than writing code which would just
have to be rewritten.

Let's be very clear - based on the value of Creativity, I don't think anyone
should have exclusive authority over how a feature works.  But that's exactly
the point - if, as the developer is working, they come up with new, interesting
ideas, that should be shared with others, properly hashed out, and reflected in
the story writeup, not just included in a pull request and shipped without
discussion.

### Code Quality

Ah, code quality.  Everyone seems to have come up with their own metric.  I have
personally lost all faith that it can be measured directly, although tools like
Flog (for Ruby) come pretty close.

I would argue that code quality is just a fancy term for changeability, and as
such, the only way to measure code quality is to see what happens when it
changes.  As time goes on, how hard does it become to add or change features?
Are there more regressions per month as the codebase grows?

I like these questions because they reinforce an important point: Code quality
is a developer aesthetic, not a direct business value.  The value emerges from
code quality when code needs to be changed, and maintenance costs are reduced
due to the code's clarity, modularity, test coverage, etc.  A zero-churn class
can have terrible, hideous code, and it does not matter at all.  Measuring later
at moments of change is a better way to assess how much the business need for
code quality is met.

Judging code quality on a team basis has the advantage of encouraging collective
responsibility.  Maybe we don't need pairing for every feature, but if everyone
is held responsible together, a proper pull request process is inevitable, and
the team will demand robust testing and continuous integration as well.  Who
wants to get stuck with misbehaving code that hurts everyone's productivity?

### Creativity

Pretty cool, a metric designed to encourage developers to rebel against their PM
masters!  Well, unfortunately, this is going to be rather boring.  I can't give
a real metric here, per se.  It comes down to a [vague] sense of whether
developers are involved in writing stories, and whether developers feel
comfortable challenging the stated requirements.

Oops, that's not really a metric for developers, is it?  It's a metric for
management.  Turns out, management can set a few policies and precedents that
make it possible for developers to contribute their whole selves to the company.
Developers can be involved early in the design and planning process, weighing in
on the feasibility, difficulty, and cost of new features, and maybe even using
some good old human intuition.  Or management can treat its developers as code
monkeys who couldn't possibly understand anything about real people who use
technology.  Of course, the latter might be bad for recruitment, which
ultimately hurts the Code Quality metric...

### Efficiency

This one is pretty simple.  It boils down to two questions:

1. Does the developer spend the entire day on Facebook?
2. Are the other principles being followed?

OK, yes, this is a cop-out.  But I sincerely believe that as long as developers
are spending a healthy quantity of time coding, following the principles
outlined above, we can all be adults and rely on developers to do their jobs.
Hopefully we are hiring productive, intelligent, and trustworthy people.

### Pulling It All Together

Sorry I lied with the title here.  Admittedly, these are not all metrics.  But
if we compare developers with other creative professionals, the whole idea of
metrics starts to sound fishy.

Copywriters, for example, might be paid by the word when quality is not
paramount.  But who would approve of paying a poet per stanza?  The best poetry
is dense and meaningful.  We judge poems by whether or not they make you think,
or bring you to tears.  And we pay novelists and poets by how much business
value they create in the form of sold books.

The fundamental mistake in judging developers by code metrics is exactly this.
We don't want developers to write X lines or close Y tickets.  We want
developers to create business value, mostly through working, useful software.
All else is just means to that end.  What functionality would be most useful?
Let's ask UX.  What is our top priority right now?  Let's check the backlog.
But make no mistake, the developer's primary job is to create value.

* **Efficiency** is obviously a matter of taking limited working hours (and
mental energies) and using them to create the most value for the company.
* **Creativity** means using technical knowledge to provide extra perspective
when driving the value-creation process.
* **Code Quality** ensures that the product actually works as expected, will
continue to work, and has potential to keep growing and generating more value.
* **Communication** recognizes that development does not exist in a vacuum.  The
most productive developer maximizes the chances that their efforts are spent on
code that will make it to production.
* **Sharing** acknowledges that there is more value in building the team's
ability to create value, long-term, than in any individual's value creation,
short-term.

Rather than thinking too much about quantifying developer performance, I would
like to shift the conversation to assessing how developers are being good team
players, building value creation potential alongside addressing current needs.
And I would like to see us viewing our developers (and everyone who works with
them) as an actual team, where individuals working and learning together
multiply the value created individually.

[Kent Beck on pairing]: https://www.quora.com/Is-pair-programming-worth-the-trade-off-in-engineering-resources/answer/Kent-Beck

---
layout: post
title: "The 3 Keys to Software Quality"
date: 2017-05-17 19:02:22 +0300
comments: true
categories: 
- blog
twitter:
  description: What comes after SOLID? Usefulness, Sustainability, and Accuracy
    will reshape your thinking on software quality.
---

Why do software projects fail?

This question is difficult to answer precisely because there isn't a single
answer.  Sometimes the blame falls to technical debt which hamstrings
scalability, the ability to ship new features, or the ability to respond to
market demands.  Other times it's the lack of business model, which sinks the
entire company.  In certain situations, various parts of the organization not
seeing eye-to-eye is the culprit; the lack of shared vision causes sales to
over-promise, engineering to develop the wrong things, or marketing to pursue
the wrong strategy.

The causes are many and varied, yet somehow as engineers we focus a lot on "Good
Code" (however we choose to define it), which fails to address most of these
problems.  Why?

<!-- more -->

If I were to hazard a guess, I'd say it's because we as technical people are
trained (or believe we are trained) to understand issues of Good Code more
easily than we can solve business challenges or organizational dysfunction.  As
humans, we tend to favor investing time in the problems we know how to solve
rather than the problems that most need careful solving ([Parkinson's Law of Triviality](https://en.wikipedia.org/wiki/Law_of_triviality)).
Good Code is a problem we think we know how to solve, so we try to solve it and
forget about the larger questions that determine the success or failure of our
endeavors.

### What is Software Quality?

Traditionally, we see the role of engineers as outputting high-quality software
that meets a particular need.  We then define "high-quality" in purely technical
terms.  This has to end.

The only point of writing software is to solve problems.  In the context of a
business, every bit of software writing should be meant to target one of three
fundamental problems every business faces:

* Generating Revenue (or, for a non-profit, doing good)
* Lowering Costs
* Reducing Risk

For the remainder of this post, I'll include those 3 elements in the (badly
defined) term "business value."  Other places on the internet may define
business value otherwise; that's fine, it's just for this post.

If the purpose of software is to generate business value, it stands to reason
that the quality of software is simply a matter of how much business value it
generates.  "Is it high-quality?" becomes a question of "How fit is it for
purpose?"

That definition will probably make a lot of engineers uncomfortable.  Isn't my
job to write code, and someone else can think about the business impact?

Sure, you could look at it that way.  But that means that the fundamental
question of whether your software is valuable&mdash;and, as I define it,
high-quality&mdash;rests in the hands of other people without your input.

So think of it this way: The more you involve yourself in understanding, and
maybe even influencing, the business elements of your project, the more
effective you'll be at creating the software your business/clients really need.

### A New Framework

We do many things as engineers and as organizations to improve the quality of
our software.  I believe all these practices really target one or more of 3
primary objectives, which I term Usefulness, Sustainability, and Accuracy.
(You'll note that the acronym is USA.  No, I didn't choose the words for the
acronym, it sort of just happened.)  Let's define these terms a bit better:

* __Usefulness__ asks the question: "Does the software solve the problem
effectively?"  It requires verifying both that the problem we imagine actually
exists, and that our product solves the problem in the way that works best for
the users.
* __Sustainability__ asks the question: "Can we keep building without
unnecessary obstacles?"  Certainly, we need to think about the software itself.
Is it written in a flexible way that will allow us to come back later and make
the changes we need?  We also need to think about the development team, which
likely undergoes far less churn than the code, and hence is even _more_
important to the sustainability of your product than the software itself.  Are
you building up the team to support constant improvement and open lines of
communication?  Does the team have any instability that threatens future
progress?
* __Accuracy__ asks the question: "Does our software work the way we think it
does?"  It focuses on the relationship between ourselves and our code.  We must
make sure that we've accurately understood the problem and the codebase, and as
new information comes in we must always ensure the state of the codebase
reflects the current state of our understanding.

With these 3 major objectives in mind, let's get into the weeds a bit and think
about how they impact our day-to-day work.

### Making it Concrete

Every team, project, and situation will have its own way of defining how various
practices support (or don't) the 3 objectives.  I'll just give a few examples of
practices that I've found to be impactful on the teams where I've worked.  Let's
start with a visual map of how I see things:

<a href="/images/USA_map_large.png" target="_blank">![Map of USA practices](/images/USA_map.png)</a>

Without getting into the gory details (though I did give [a talk](/railsconf2017)
about that), here's a guide to interpreting that picture.

The blue circle on the bottom is probably easiest to understand.  It includes a
variety of practices designed to increase confidence that what's in your head
matches what's in the code.  This includes testing practices, programming
language features, tools and techniques for reducing complexity, and increasing
the number of programmers who see and interact with code before it's committed
and deployed.

The green circle on the top-right is about maintaining flexibility while
avoiding elements of instability.  Anything that makes it easier to build
without breaking things, creating a tangled mess, or backing yourself into a
corner (from a perspective of product development) goes there.  Also included
are practices that build the team, improve the skills of developers, and make it
easy (in the context of a larger organization) to interoperate with other teams
and/or move people across team boundaries.

The top-left red circle is about connecting our applications to their purpose.
Probably the most important piece is "Focus on Delivering Value"; all else can
be derived from it.  The red circle is populated by practices that help you
understand your users more effectively, keep their needs in mind as you code,
and do the most important work first.  There are elements of both making the
solution that works for them (researching their needs, making it performant) and
making the solution work for them (providing it when they need it, with
appropriate documentation, and the ability to find what they need).

One non-obvious (and likely controversial) thing is the fact that I've put a
number of technical practices into the red circle.  I believe that when we have
multiple people working on code, or we explicitly document how a system is to be
used via integration testing, that helps us focus on the end value provided to
the user, at least opening up space for having conversations about the business
value created by our software.  I don't think we've fulfilled our obligation to
the Usefulness objective just by doing those things, but they're a good start.

I've also mentioned a few central practices, which are just my opinion (as is
the rest of this map):

* I believe having a broad-based __testing__ strategy provides meaningful signal on
all 3, since it allows you to write correct code the first time, avoid breaking
it later, and&mdash;if you write proper integration tests&mdash;helps you to
keep user needs in mind.
* __Pairing__ and __mobbing__ help you write code with fewer mistakes, build the
team going forward, and provide space for conversations about the purpose of the
current task and how to best accomplish it.
* The Single Responsibility Principle (__SRP__) is about making sure each part
of your system does one thing, and does it well.  This makes it easier to write
accurate code the first time; if the purpose is clearly defined, it's much
easier to test whether the code actually achieves it.  It's also easier to come
back later and make a change, since you know exactly what to change.  Finally,
focusing on the purpose of your code helps keep in mind the big picture of why
you're writing the code in the first place.
* __Frequent releases__ allow you to deliver value more quickly to the user.  If
you think of value creation as represented by (_value created per time_ ⨉ _time
software is in use_), it's clear that shipping value earlier beats later.
Frequent releases also allow you to find bugs more quickly (users are really
good at figuring out when your software is broken!) and avoid building castles
on top of flawed ideas you only find out are flawed months later (hence helping
Sustainability).

Again, these are just my own opinions, based on my experiences with these
practices and how I've seen them utilized on the teams I've been part of.  Your
team will derive more or less, and different, benefit(s) from these same
practices, and that's normal and expected.

As an exercise, I've made a blank version of the map available in
[PDF](/assets/railsconf-2017/exercise.pdf),
[Keynote](/assets/railsconf-2017/exercise.key), or
[PowerPoint](/assets/railsconf-2017/exercise.pptx) form for you to fill out with
your own teams.  I'd love to see how your maps stack up against mine!

### Bridging the Gap

Bob Martin, citing Kent Beck, [wrote](https://8thlight.com/blog/uncle-bob/2014/03/28/The-Corruption-of-Agile.html)
that the Agile Manifesto was intended "to heal the divide between development
and business."  Unfortunately, 16 years later, that's nowhere near a solved
problem.

I believe that divide can be healed if we learn to speak a common language,
relating elements of technical excellence to meeting business needs, showing how
the things we care about as engineers are things everyone should care about.
That means going beyond our technical peers to understand the needs of other
parts of our organizations, and figuring out our role in meeting those needs.

If we learn to speak the language of business, just a little bit, we can expect
to see a lot more understanding and respect coming in the opposite direction,
from businesspeople to developers.  Maybe we'll even develop psychological
safety and trust.  Wouldn't that be great!

We're all in this together.  Let's start acting like it.

_Note: Based on a talk given at RailsConf 2017. Check out the original
talk [here](/railsconf2017)._

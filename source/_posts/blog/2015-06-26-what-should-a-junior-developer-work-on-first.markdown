---
layout: post
title: "What Should a Junior Developer Work On First?"
date: 2015-06-29 1:01:19 +0300
comments: true
categories:
- blog
- Programming
twitter:
  description: Reflections after a year in the field working as a developer.
---

Recently, a new member of our team asked me (and other coworkers) to list 3
things a junior developer should accomplish within their first 3 months on the
job.  Being at the end of my first year on the job, it was an excellent
opportunity for reflection on what I have learned during this year which was
most useful.

After some thinking, I came up with 3 concrete goals, emblematic of 3
big-picture objectives which should be guiding lights for the new developer.

Here are my picks:

1. Be reasonably comfortable with TDD
2. Write good commit/PR messages
3. Present at a team hangout

These might seem like arbitrary goals, so they deserve some explanation.

<!-- more -->

First, you'll notice that I did not mention "learn X language" or "become
proficient in Y framework."  This is simply because languages and frameworks are
important, but not inherent, goals.  The languages and libraries you use today
will most likely fade with time, to be replaced by newer tools more appropriate
for the tasks of tomorrow.  But _how_ to write code will be just as relevant in
30 years as it was 30 years ago.  Design principles evolve as well, but the idea
of designing code, rather than just getting things to work, is the most
important, and biggest, jump.

Now, let's move on to expanding these concrete goals into coherent broad ideas.

## TDD: A Design Tool

"Why test?" is a very complicated question with a lot of answers.  Justin Searls
has [an excellent talk][Justin Searls talk] listing about 10 different reasons
for testing.  The reason I focus on TDD here is because it is the most powerful
technique I know for learning how to design code from the outside in.

As a new developer, you are probably focused on assimilating the multitude of
new technologies you need to master to get things to work.  It probably seems
odd that I would recommend focusing on technique, rather than just staying
afloat.

However, I would argue that feeling lost is just part of being a software
developer today.  There is a constant influx of new languages, frameworks, and
tools, and it is far too easy to be satisfied with just making things work.
However, programmers who excel in their careers make sure to reserve time for
becoming better at the basics of how to write good code.  If you don't make time
for that now, when will you?

There are many ways of becoming better.  You can get ideas from articles and
conference lectures, books and blog posts.  But there is a jump to be made from
the theoretical to the practical.

#### What is "good code"?

Good code, among other qualities, is modular and intuitive.

* By modular, I mean that each piece carries a responsibility appropriate for
its size.  Methods do just one thing, and do it well.  Classes are the same, but
a "thing" is a larger unit of work.  Collaborating objects form systems that
accomplish yet larger things, but at every level, there is a single unifying
theme to the system.[^1]
* By intuitive, I mean that it acts in the way you would expect, both from the
outside and once you open it up.  The outside piece of that statement means that
its public API provides as few surprises as possible.  The input/output, as
closely as possible, matches what the average programmer would expect it to be.
Additionally, the innards are divvied up in a fashion that makes it easy for
someone new to the codebase to interpret and reason about.  Clever hacks or
thrown-together solutions are generally not intuitive, and tough to modify
later.

#### So what does TDD have to do with all this?
TDD enforces (as much as is possible to enforce such things) code which is
modular and intuitive.

It is exceptionally difficult to write tests for code which is not modular.
Generally speaking, code with intertwined responsibilities will also have deep
interdependencies between modules.  This causes immense pain in testing,
encouraging the programmer to think about how to tease apart responsibility and
dependency.

Yet beyond that testing pain, there is a larger point: it is very hard to test
code when you don't understand its responsibility.  Usually, if you have not
defined what code is supposed to do, it will be nearly impossible to write the
tests first, because the tests are simply a concretion of the responsibilities
of the code you are about to write.  By following the principles of TDD, you
encourage yourself to state your goals, thereby breaking up your code before you
have written a mess of intertwined modules.

TDD also strongly encourages intuitive code.  When engaged in TDD, you should be
testing only the public API of your code, defining inputs and expected outputs,
before you figure out the implementation.  This means that your primary goal
when writing the code itself is to meet the needs that you have already
described in your tests.  This, in turn, means that you are thinking first about
the user of your code, and only afterwards about the internal algorithms and
details involved in your solution.  That leads to code which is friendlier for
outside use.

I don't think TDD necessarily offers much direction in terms of properly writing
the internals of your code, but I never promised a single, all-encompassing
solution, did I? 😉

Based on all this, I think that becoming comfortable with TDD is a highly time-
and effort-efficient method of speeding up the learning curve for excellent
coding habits.  Even if it's not the approach you take all the time (and hey,
[even Kent Beck doesn't think it should be][Kent Beck TDD]), it's a worthy
exercise to practice skills and thought patterns which ultimately will be quite
useful regardless of your workflow.

## Commit and PR Messages: A Primary Source of Communication

One of the most important lessons to learn as a junior developer is that, unless
you are the only developer on your team, your code is a shared entity.  Your job
is not to be personally awesome, but rather to help your entire team be awesome.
This means you need to sometimes sacrifice some of your own productivity in
order to help everyone else be more productive.

Commit messages are a prime example of this.  In just a few seconds per commit,
you have the opportunity to lay out a trail of breadcrumbs to lead members of
your team toward understanding why certain decisions were made, why this was
added and that deleted.  You instruct them as to what code is relevant to a
particular feature, and what dangers would be involved in deleting it.

Pull request messages are, in a sense, just a broader repetition of the same
motif.  Rather than explaining a small bit of work, they expound on the
rationale for a set of adjustments to your application.  But if your team uses
a pull request-based workflow, these messages are even more important.  Rather
than reading your code and puzzling over what you were trying to accomplish,
your teammates can quickly understand your goals, and then evaluate whether you
achieved them in the best way possible.  A good pull request message can be the
difference between "It looks like code, guess I'll merge it!" versus "That was
an interesting choice of how to tackle this issue, we should discuss it
further."  If you invest in the quality of code review on your submissions, you
will be rewarded with plenty of free advice on how to make your next bit of work
even better.

#### Look Into Your Future...

Beyond the basic point of just being a good teammate, there is another
compelling reason to write clear, thorough commit and PR messages: The next
person who has to read them just might be you.

Let's face it.  We might all talk about collective responsibility for a code
base, but if you wrote the code, you will likely be called in to explain why it
was written the way it was.  And you will also probably have forgotten by that
point why you did things that way.

If you leave yourself clear commit and PR messages, they will serve as memory
jogs so you can figure things out far more quickly.  If you left a bunch of code
with commit messages like "fixed a thing" and "it works now" - well, you're
gonna have a bad time.  And you will probably misunderstand your own code, and
break lots of things.

Realistically, what percentage of commits or PR messages will you ever read
again?  Probably no more than 5-10%.  But the amount of time you will save in
those 5-10% of cases is well worth the small upfront investment of archiving
your thoughts.

So care about your teammates, and care about your future self.  Learn to write
clear commit and PR messages, and you will thank yourself later when they are
your "primary source" of information about days of coding past.

## Presenting: The Code Is Not Enough

Software, like any slice of the human enterprise, is really more about the
people making it than the product itself.  Most problems in software stem from
the people making it.  It follows that software will be as coherent as is the
communication amongst its developers.

If you want to be a successful coder, you also need to be a successful
communicator.

There are many formats of communication, including commit and PR messages, as
discussed above.  Most people can get along in one-on-one conversation, though
some (including myself) struggle even with that.  But even for people who are
natural conversationalists, presenting to a group can be difficult.  Yet it is
also necessary to learn how to present one's ideas cogently and convincingly to
a group.

The other salient point is that many junior software engineers are convinced
that they are no good, or at the very least so inferior to senior developers
that nothing they themselves say could possibly be of interest to others with
more experience.  Yet that could not be farther from the truth.

#### Junior Devs: A Critical Voice In Our Community

Junior developers need to understand: Your ideas are valuable.  You came into
this profession, this artisans' guild, because you find beauty in well-organized
code, you are awed by the power of loops and function calls and recursion, you
draw excitement from optimizing an algorithm from _O(n<sup>2</sup>)_ to _O(n)_.  (At
least, I hope you do; otherwise, you'll be pretty bored in this business.)  You
see opportunity in new technologies, and you are still developing heuristics to
evaluate the tradeoffs inherent in choosing one over the other.

You are a neophyte.  And neophytes tend to ask the most interesting questions,
forcing people more experienced than themselves to articulate their opinions and
perspectives on issues that matter to everyone.

Because you are new to the trade, your ideas and experiences are valuable, and
your enthusiasm gives light and warmth to those who may have forgotten the
excitement of their earlier coding days.

So even if you speak about a technical topic they are thoroughly familiar with,
senior developers will still enjoy your presentation.

#### Senior Devs: Seeing Beyond the Pedestal

If you are not yet convinced, let me offer another argument.

Senior developers are simply programmers with more experience writing (hopefully
good) code, more familiarity with the breadth of languages and tools, and a
better understanding of the system underlying all programming platforms.  But
they are hardly godlike omniscient beings.  It's not too hard to find a topic
that the senior developers on your team haven't delved into, or at least offer a
fresh perspective which would be of interest to them.

Even if they are generally familiar with a topic, even if they utilize that
knowledge on a daily basis, there are still going to be some points that they
have forgotten or never learned about, so they will walk away with some useful
bits of knowledge from your presentation.

Finally, seniors are often interested, for business reasons or out of altruistic
motivations, in bringing in juniors and helping them to be as productive as
possible.  Your struggles in your work are useful and informative to more senior
folks on your team, helping them to reassess the process and iterate on their
onboarding process for new junior developers.[^2]

Your thoughts and learning will be of value to others, and by presenting, you
will develop a critical skill which - if not properly nurtured - could be the
barrier between you and a highly successful career.

## Summing It Up

Now that we've provided some theoretical background, the 3 goals listed above
might be stated as:

1. Learning to design code effectively
2. Being a communicative team player
3. Gaining confidence in your worth as a coder

Since I believe in concrete, rather than abstract, goals, I will stick with the
list above as a more helpful set of discrete accomplishments to be aimed for in
the first few months.  But with the broader goals in mind, hopefully the
specifics make more sense as guideposts on the journey toward a long, enjoyable,
successful career in code.

_What do _you_ think are the most important things for junior developers to work
on in their first few months on the job?  Share your thoughts in the comments!_

[Justin Searls talk]: https://www.youtube.com/watch?v=9_3RsSvgRd4
[Kent Beck TDD]: http://www.quora.com/Does-Kent-Beck-use-TDD-at-Facebook-How
[^1]: Modularity also often refers to the packaging of code into discrete bits which can be used elsewhere in your system.  I personally find the reuse of modules to be neither very common nor very fundamental to the practice of software engineering.  While it can be a useful technique on occasion, I hardly believe it to be one of the first few things a developer absolutely needs to learn.
[^2]: This applies in the open source community as well.  I am personally familiar with one meetup in NYC which often asks developers new to their open source project to speak about their experiences and challenges, to guide the maintainers towards providing useful tools and documentation for new users.

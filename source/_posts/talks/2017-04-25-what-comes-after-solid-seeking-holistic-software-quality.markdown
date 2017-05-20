---
layout: post
title: "What Comes After SOLID? Seeking Holistic Software Quality"
date: 2017-04-25 14:40:00 -0500
comments: true
categories:
- talks
tags:
- Business
- Empathy
- Code Quality
- Software Quality
twitter:
  description: A new way to assess the quality of software, set the right goals,
    and find balance in our coding practices. Good Code isn't enough.
---

This talk was given at RailsConf 2017.  For a pared-down text version of the
talk, see [this post](/blog/2017/05/17/the-3-keys-to-software-quality/).  For
the real thing, here's the video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/5wYcD1nfnWw" frameborder="0" allowfullscreen></iframe>

And the slides:

<script async class="speakerdeck-embed" data-id="13c5b841f7114d6ca8155dfabb1a9f93" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

<br/>
#### Talk Description:
You care deeply about code quality and constantly strive to learn more. You
devour books and blogs, watch conference talks, and practice code katas.

That's excellent! But immaculately factored code and clean architecture alone
won't guarantee quality software.

As a developer, your job isn't to write Good Code. It's to deliver value for
people. In that light, we'll examine the effects of a host of popular coding
practices. What do they accomplish? Where do they fall short?

We'll set meaningful goals for well-rounded, high-quality software that solves
important problems for real people.

#### Exercise from the talk:
Download the exercise as a [PDF](/assets/railsconf-2017/exercise.pdf),
[Keynote](/assets/railsconf-2017/exercise.key), or
[PowerPoint](/assets/railsconf-2017/exercise.pptx) file.

#### Talk Errata:
Reflecting afterwards, I noticed a few mistakes I made in the presentation, and
would like to note them here:

1. I confused [Cyclomatic Complexity](https://en.wikipedia.org/wiki/Cyclomatic_complexity)
with the [ABC (Assignments, Branching, and Conditionals)](https://en.wikipedia.org/wiki/ABC_score)
metric.  Branching is very similar to cyclomatic complexity, but technically
[ABC is a software size metric, not a complexity metric](http://wiki.c2.com/?AbcMetric),
and it encompasses more than cyclomatic complexity.
1. I mentioned [Flay](http://ruby.sadi.st/Flay.html) when I had intended to
reference [Flog](http://ruby.sadi.st/Flog.html); the former is a tool for
locating duplication, while the latter is actually a measure of ABC in Ruby.
1. Code Review is generally done after checking code into source control; the
intention was that it's done before code is moved into the main (master) branch
of a central repository.

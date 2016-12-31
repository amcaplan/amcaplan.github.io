---
layout: post
title: "How to Give a Great Tech Conference Talk"
date: 2016-12-31 20:50:21 +0200
comments: true
categories:
- blog
twitter:
  description: Giving a great tech talk isn't as hard as you'd expect. All you
    need to do is tell a good story.
---

People come to tech conferences for many reasons.  They want to hear about new
ideas and technologies, to be inspired with the latest and greatest of what the
programming community has to offer.

But once people are actually at a conference, especially a larger conference,
the number of things to do and to absorb can be overwhelming.  There are talks,
maybe even multiple talks at once, there's the hallway track, vendor booths, and
of course the great big world outside where people escape when they want a
break.  Everyone competes for attention, offering excitement, swag, fun hacking
activities, and/or the alluring prospect of job opportunities.

Then there's the new practice of posting talks online.  This opens up talks to
new audiences who couldn't make it, which is fantastic.  It also means that if
the community loves a talk, it could be see by thousands more people than were
at the conference!  The downside is that conference attendees may be more likely
to skip talks because they're all online later anyway, meaning that speakers
lose the opportunity to build off the speaker-audience interaction.

What's a speaker to do?

<!-- more -->

### One Core Principle

I have to admit something upfront.  This post isn't really about how to give a
great conference talk per se.  It's about how to give a conference talk I'm
going to want to watch.  And as a conference-goer, I want to watch a talk that
tells a coherent, interesting story.

The good news is that, according to science, the other attendees think the same
way.  Stories impact the brain in a truly wild fashion.

* [Stories match the way our not-always-logical brains think about the world](https://blogs.scientificamerican.com/guest-blog/it-is-in-our-nature-to-need-stories/).
* [Stories activate many parts of the brain, involving our entire brain rather than just language centers.](https://blog.bufferapp.com/science-of-storytelling-why-telling-a-story-is-the-most-powerful-way-to-activate-our-brains)
* [We feel empathy for storytellers.](http://greatergood.berkeley.edu/article/item/how_stories_change_brain)
* [We remember stories better than we remember facts.](https://www.theguardian.com/media-network/media-network-blog/2014/aug/28/science-storytelling-digital-marketing)

Of course, much of this makes sense if we reflect on our own lives.  When you
watch a movie, you worry about what will happen to the characters, even though
you know they're not real.  When a character is maimed or killed, you feel pain,
even though no one has hurt you.

When you read dry statistics about suffering, it probably doesn't motivate you
to action.  When you see a video with a tearful person describing some horror
they suffered&mdash;well, that's another matter entirely.  This is why charities
seeking donations rely mostly on monologue videos, stories, and even handwritten
thank-you letters, rather than facts and figures.
[Stories motivate people to act.](http://greatergood.berkeley.edu/article/item/how_stories_change_brain)

Think about how many religions don't have founding myths.  Can you think of any?
Me neither.  People don't dedicate their lives to ideals, noble though that may
sound.  A compelling story, though... now we're talking.

You want to give an interesting talk.  You want the conference attendees to
come, and you want the online crowd to hear out the whole talk, not leave the
video after 2 minutes.

You want your conference talk to make an impact.  You want people to remember it
and talk about it.  You want people to learn from it and apply your ideas in
their own lives.

Tell a story.

### Story Type 1: The Audience as Protagonist

No blog post about stories would be complete without a few personal stories,
right?  Well, get ready, because here they come!

My first conference talk was at RailsConf 2016, where I spoke about Rails
engines.  This was the abstract:

> Want to split up your Rails app into pieces but not sure where to begin? Wish
> you could share controller code among microservices but don’t know how? Do you
> work on lots of projects and have boilerplate Rails code repeated in each?

> Rails Engines may be your answer.

> By building a simple Rails engine together, we will better understand how this
> app-within-an-app architecture can help you write more modular code, which can
> be gemified and reused across multiple projects.

It doesn't appear to be a story at first glance, but read it again.  In case you
missed it, here's the story:

> Once upon a time, you had a messy app that was suffering for lack of
> modularity.  Or, you kept writing the same boilerplate multiple times.

> Then, a conference talk showed you how to build Rails engines, and you were
> able to take control and conquer your mess.  You were awesomer and your apps
> were healthier.

> The end.

One of the best stories you can offer people is that you will make their lives
happier and better.  (Unfortunately this tendency can be abused by
ill-intentioned people out to make a buck.)  In this case, though, I made a
simple value proposition which I truly believed in, and the result was that
every chair in the workshop had a butt in it, and 130 people walked out having
built their first Rails engine.

### Story Type 2: The Code as Protagonist

I'd like to focus for a moment on a feature of the Rails engines talk which
stood out dramatically for me.

In the introductory portion to my workshop, I had to convey that Rails can route
a request to any Rack app.  This point is critical to understanding Rails
engines, because they take advantage of this feature of Rails to tie into Rails
apps.  I wanted my audience to build an accurate mental model of how Rails
engines are integrated under the hood, and this was the critical point for them
to understand.

I could have thrown that information on a slide, said a few words about it, and
moved on.  But information conveyed that way is easily missed, and I didn't want
to lose people through confusion about this point.

So I told a story.

I told my audience I would build, before their eyes, a perfectly functional
Rails application without using models, views, or controllers.  I created a new,
blank Rails application, and added an empty lambda to my `routes.rb` file.
Then, step by step, I let the errors guide me to building out that lambda into a
minimal Rack application serving a response to a single endpoint.

Could I have just pre-built a Rails app containing a Rack app?  Yes, of course.
But building up the tension through live code, and letting errors drive the
coding, let the audience discover with me the ability to hook Rack applications
into Rails apps.

After the talk (as well as in practice runs before), this was the part that
generated the most positive feedback.  It wasn't all that difficult to do, but
the experience of watching code develop incrementally was riveting for the
audience.  It has all the parts of classic storytelling: Facing a seemingly
impossible challenge, a hero must discover heretofore unknown abilities, and
then is able to surmount the obstacle.  In this case, the impossible challenge
was building a Rails app without controllers, and the unknown ability was using
a barebones Rack app.

That talk unfortunately wasn't recorded, but I can give a favorite example: the
late Jim Weirich's [legendary talk on the Y combinator](https://www.youtube.com/watch?v=FITJMJjASUs).
The experience of watching a master develop an idea through code is enough to
send chills down my spine.

Of course, live coding isn't for everyone.  But if you present code in your
talk, I'd strongly recommend starting with the problem the code has to solve,
then building out the solution incrementally.  Don't just show what your code
does; talk about the obstacles it has to overcome, and the process of getting
there.

### Story Type 3: The Speaker as Protagonist

My most recent talk was given at WindyCityRails 2016 then repeated (and
improved!) at RubyConf 2016.  The approach here was different.  The subject of
the talk was improvements to Ruby's `OpenStruct` library, but I also came in
with a lot of personal experience.  I had dealt with `OpenStruct`-related
performance problems in the past, which let me to publishing 2 alternative
solutions.

In the first half of the talk, I established the importance of `OpenStruct` to
the Ruby ecosystem, and the reasons for its performance problems.  Then I made
it personal, by talking about how these performance issues affected my company's
projects.

With the tension established, I spoke about 4 different approaches to the
problem, framing it in terms of my own experience with each solution, and how
they succeeded or failed in solving the problems I was having.

Since 2 of the approaches were libraries I had personally written, I was able to
convey a sense of personal triumph in the degree of success they achieved.  And
when I concluded my talk with some lessons learned, they weren't just logically
derivable ideas; they were thing I had personally learned through my experience.

I was originally worried that the very personal nature of the talk would hurt
its reception.  Then something amazing happened.

WindyCityRails asks participants for written feedback after the conference, then
collects and summarizes the responses for the speakers as an exercise in
reflection and self-improvement.  There were many really nice, general comments,
but 2 specific responses stuck with me:

> I enjoyed the narrative, "I tried, I failed, I tried again" aspect of this.

<!-- comment needed in Markdown to separate comments ☹️ -->
> Best presentation of the conference. Connected with me.

It turns out, people really like hearing a good story.  I didn't just tell them
about an abstract problem and some ways to handle it.  (We've all heard lots of
talks which do exactly that!)  I told them the story of my problem, and how I
used tools like benchmarking, profiling, and reading code to find a solution
that worked for me.  I told my story in a way that conveyed to the audience that
they, too, can use these tools to solve problems they face.

As a speaker, you may be afraid to make your talk too personal.
[Some](https://www.youtube.com/watch?v=V69Sinlp6Ew)
[of](https://www.youtube.com/watch?v=cGuTmOUdFbo)
[the](https://www.youtube.com/watch?v=wewAC5X_CZ8)
[best](https://www.youtube.com/watch?v=gTAghAJcO1o)
[talks](https://www.youtube.com/watch?v=aApmOZwdPqA)
[I've](https://www.youtube.com/watch?v=gX4FwSJ4JwI)
[watched](https://vimeo.com/148927676)
mostly or entirely follow a narrative or set of highly personal narratives.  And
they're all the more engaging for it.

### A Story Within a Story

You don't have to choose just one method or one story.  Even within a story, you
can use a deeper level of story to great effect.

In my `OpenStruct` talk, for example, I had to explain how
`OpenStruct`&mdash;a hash-like data store&mdash;and its alternatives work.  It's
generally notoriously difficult to explain code and algorithms in a short span
of time.

To counteract the problem, I kept things as concrete and story-like as possible.
I introduced the code one piece at a time, following the trajectory of a single
key-value pair inserted into the `OpenStruct` (or alternative) instance.  By
following a linear narrative, I was able to convey the information to the
audience quickly and effectively, without them realizing how much data I was
streaming into their brains.

The same principle is at play when someone spends a few minutes of a talk live
coding, or telling a quick personal anecdote to drive the point home.  By
incorporating short stories (or story-like experiences like live coding) into
the framework of a talk, you can make your presentation more engaging, connect
with your audience, and help them walk away having gained the maximum from your
presentation.

One really great example is [this talk about effective feedback](https://www.youtube.com/watch?v=EkLdO-SphxA),
where (just after the 20-minute mark) [the speaker](https://twitter.com/pyluftig)
uses a personal anecdote to illustrate both ineffective and effective feedback.
The story drives home the ideas conveyed earlier in the entire talk.

### Writing Your Story

Great talks aren't made in a day, or even a few days.  It can take years to
write a great talk.  The best talks aren't from people who woke up with bright
ideas; they come from people who experienced something over months and years,
and share their experiences in a personal, intellectually and emotionally
captivating fashion.

If you want to give an amazing tech talk, don't start by making slides or
sketching out bullet points.  Go out and do something.  Experiment, try a new
way of working, build an OSS library or contribute to one.  Get involved in your
local tech community, be a mentor at work, volunteer in your free time.  Do
interesting things, have experiences, and then think long and hard about them,
learn what you can, and synthesize your learning&mdash;along with the story of
what taught you those lessons&mdash;into the next great talk.

People like to hear from experts.  You are the world expert on your life, your
emotions, your projects, your history, and your growth.  And you'll be surprised
by how much people are interested in learning about that.

To give a great conference talk, take the time to build a story worth telling.
And then share it with the world.  But don't just bring the facts and figures
and details to the stage.

Bring yourself.  Be yourself.  Share yourself.

***Written as part of the 2016 [8 Crazy Blog Posts Challenge](/blog/2016/12/25/8-crazy-blog-posts).***

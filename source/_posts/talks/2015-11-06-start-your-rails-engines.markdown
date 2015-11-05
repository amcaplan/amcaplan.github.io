---
layout: post
title: "Start Your (Rails) Engines!"
date: 2015-11-06 00:01:36 +0200
comments: true
categories:
- talks
tags:
- Ruby
- Rails
twitter:
  description: Learn the basics of building and integrating Rails Engines, and
    consider when they are or aren't the best solution.
---

### The Talk

This talk was given at RailsRemoteConf 2015.

Check out the [SpeakerDeck][SpeakerDeck]!  Video coming soon!

<script async class="speakerdeck-embed" data-id="f1a29cab92da437284c27653a1525131" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

Want to split up your Rails app into pieces but not sure where to begin? Wish
you could share controller code among microservices but don't know how? Do you
work on lots of projects and have boilerplate Rails code repeated in each?

Rails Engines may be your answer.

We will build a simple Rails engine and understand how this app-within-an-app
architecture can help you write more modular code which can be gemified and
reused across multiple projects.

<br /><br />

### Following Along

The video will be made public... eventually.

In the meantime, you can check out the code from the "live code" portion at
[https://github.com/amcaplan/forget](https://github.com/amcaplan/forget) and
[https://github.com/amcaplan/cacher](https://github.com/amcaplan/cacher). I also
edited my notes from the live code portion, and published them at
[https://gist.github.com/amcaplan/0841065fdb69966b860f](https://gist.github.com/amcaplan/0841065fdb69966b860f).

For your convenience, here are the links from the talk.

<br />

#### Links Throughout the Presentation

[http://guides.rubyonrails.org/engines.html](http://guides.rubyonrails.org/engines.html)

[https://github.com/rails/rails/blob/master/railties/lib/rails/application.rb#L79](https://github.com/rails/rails/blob/master/railties/lib/rails/application.rb#L79)

[http://weblog.rubyonrails.org/2005/11/11/why-engines-and-components-are-not-evil-but-distracting/](http://weblog.rubyonrails.org/2005/11/11/why-engines-and-components-are-not-evil-but-distracting/)

[http://article.gmane.org/gmane.comp.lang.ruby.rails/29166](http://article.gmane.org/gmane.comp.lang.ruby.rails/29166)

[https://techblog.livingsocial.com/blog/2014/01/24/open-sourcing-with-rails-engines/](https://techblog.livingsocial.com/blog/2014/01/24/open-sourcing-with-rails-engines/)

<br />

#### Further information links

[GoGaRuCo 2012, Erik Michaels-Ober - “Writing a Rails Engine”](https://www.youtube.com/watch?v=MsRPxS7Cu_Q)

[Ben Smith - “Leave your migrations in your Rails engines”](http://blog.pivotal.io/labs/labs/leave-your-migrations-in-your-rails-engines)

[RailsConf 2015, Stephan Hagemann - “Get started with Component-based Rails applications!”](https://www.youtube.com/watch?v=MsRPxS7Cu_Q)

[Brian Leonard, “Rails 4 Engines” (Blog post about splitting up an application)](http://tech.taskrabbit.com/blog/2014/02/11/rails-4-engines/)

[Rocky Mountain Ruby 2013, Ben Smith - “How I architected my big Rails app for success!”](https://www.youtube.com/watch?v=uDaBtqEYNBo)

[Stephan Hagemann, “Migrating from a single Rails app to a suite of Rails engines”](http://blog.pivotal.io/labs/labs/migrating-from-a-single-rails-app-to-a-suite-of-rails-engines)

[Will Read, “Experience Report: Engine Usage That Didn't Work”](http://blog.pivotal.io/labs/labs/experience-report-engine-usage-that-didn-t-work)

[SpeakerDeck]: https://speakerdeck.com/amcaplan/start-your-rails-engines-railsremoteconf-2015

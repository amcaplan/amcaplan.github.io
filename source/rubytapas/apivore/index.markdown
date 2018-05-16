---
layout: post
title: "Further Reading on Swagger and Apivore"
date: 2018-05-16 14:40:00 -0500
categories: []
twitter:
  description: Watched the RubyTapas episode on Swagger and Apivore, and craving
    more? Your prayers have been answered.
---

If you watched my RubyTapas guest episode introducing Documentation-Driven
Development with Swagger and Apivore, you just saw a brief introduction
and probably want more information on setup and best practices.

### Swagger

For starters, it's worth learning more about the
[OpenAPI/Swagger Specification](https://swagger.io/specification/) and the
[tooling offered by Swagger](https://swagger.io/tools/).  To get a better sense
of the capabilities of Swagger in a user-facing sense, I'd recommend looking at
the [Swagger Petstore](https://petstore.swagger.io/).

There are a number of Ruby-specific tools for generating Swagger docs, but I've
found it easiest to remove the abstraction and deal directly with the YAML using
the official [Swagger editor](https://editor.swagger.io/).

### Apivore

To learn about Apivore, I'd recommend first looking over the documentation on
the [official GitHub repo](https://github.com/westfieldlabs/apivore).  It has
enough to get started, but I'd recommend first looking at a few other things.

First of all, I wrote a [blog post](https://amcaplan.ninja/blog/2016/12/27/automating-empathy-test-your-documentation-with-swagger-and-apivore/)
describing some practices I've found effective for getting up and running and
creating a concise, maintainable test suite.  Among other things, you'll find
useful code snippets for your own apps.

I also gave a [talk at RailsConf 2018](https://amcaplan.ninja/talks/2018/04/19/automating-empathy-test-your-docs-with-swagger-and-apivore/)
elaborating more on the how and why of Documentation-Driven Development with
Swagger and Apivore, which goes into much more detail than we could fit into a
single RubyTapas episode.

Finally, if you're a devoted MiniTest user, you'll want to try out
[mini-apivore](https://github.com/alekseyl/mini-apivore), which is a port of
Apivore that works with MiniTest.

### Caveats, Criticisms, and Alternatives

While Documentation-Driven Development as an idea carries a strong value
proposition, the specific implementation I've advocated sometimes leave what to
be desired.

Apivore has a number of issues, including the fact that it's rarely updated, it
doesn't support the latest version of Swagger (3.0), and it doesn't test inputs.
For some more subjective criticism, I'd recommend a [post](https://blog.apisyouwonthate.com/keeping-documentation-honest-d9ab5351ddd4)
on the topic by Phil Sturgeon, an author and speaker in the field of API design.
He advocated for a different preferred solution, [Dredd](https://dredd.readthedocs.io/en/latest/),
which is worth investigating as an alternative to pair with Swagger.

I responded with some of [my own thoughts](https://medium.com/@arielmcaplan/hi-im-the-author-of-the-aforementioned-blog-post-about-apivore-f514a7687de0)
as a long-time user of Apivore, which you may find useful as well.

Finally, it's always worth looking at the official list of
[Swagger open source tools for Ruby](https://swagger.io/open-source-integrations/#ruby-22)
for the most up-to-date information on the growing toolkit available to Swagger
users.

Happy hacking!

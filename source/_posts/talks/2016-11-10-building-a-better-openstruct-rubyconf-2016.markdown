---
layout: post
title: "Building a Better OpenStruct - RubyConf 2016"
date: 2016-11-10 14:01:52 -0500
comments: true
categories:
- talks
tags:
- Ruby
- OpenStruct
- RubyConf
- Performance
- Optimization
- Benchmarks
- Profiling
twitter:
  description: OpenStruct provides a sweet API for data objects, but its
    performance is problematic. Can we build it better?
---

This talk was given at RubyConf 2016. It's an updated version of [the same talk from WindyCityRails 2016.](/talks/2016/09/16/building-a-better-openstruct/)

Here are the slides:

<script async class="speakerdeck-embed" data-id="7ed494d4b4244f26a453c97aa9efc75d" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

<br/>
#### Talk Description:
OpenStruct, part of Ruby's standard library, is prized for its beautiful API. It provides dynamic data objects with automatically generated getters and setters. Unfortunately, OpenStruct also carries a hefty performance penalty.

Luckily, Rubyists have recently improved OpenStruct performance and provided some alternatives. We'll study their approaches, learning to take advantage of the tools in our ecosystem while advancing the state our community.

Sometimes, we can have our cake and eat it too. But it takes creativity, hard work, and willingness to question why things are the way they are.

#### Link from the talk:
http://jamesgolick.com/2013/4/14/mris-method-caches.html


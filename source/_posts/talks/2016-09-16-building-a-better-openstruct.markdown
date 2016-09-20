---
layout: post
title: "Building a Better OpenStruct"
date: 2016-09-16 11:25:09 -0500
comments: true
categories:
- talks
tags:
- Ruby
- OpenStruct
- WindyCityRails
- Performance
- Optimization
- Benchmarks
twitter:
  description: OpenStruct provides a sweet API for data objects, but its
    performance is problematic. Can we build it better?
---

This talk was given at WindyCityRails 2016.

Until the official conference video is posted around October, here's a screen capture (sorry about the poor audio quality):

<iframe width="560" height="315" src="https://www.youtube.com/embed/m22kVEUiOvM" frameborder="0" allowfullscreen></iframe>

Here are the slides:

<script async class="speakerdeck-embed" data-id="a58b363d2b76458ea09bee059d5e34e5" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

<br/>
#### Talk Description:
OpenStruct, part of Ruby’s standard library, is prized for its beautiful API. It provides dynamic data objects with automatically generated getters and setters. Unfortunately, OpenStruct also carries a hefty performance penalty.

Recently, Rubyists have tried various approaches to speed up OpenStruct or provide alternatives. We will study these attempts, learning how to take advantage of the tools in our ecosystem while advancing the state of the Ruby community.

Sometimes, we can have our cake and eat it too. But it takes creativity, hard work, and willingness to question why things are the way they are.

#### Link from the talk:
http://jamesgolick.com/2013/4/14/mris-method-caches.html

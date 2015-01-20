---
layout: post
title: "Flag Your Features with Rollout and Degrade"
date: 2015-01-14 13:05:10 -0500
comments: true
categories:
- talks
tags:
- Ruby
- gems
---

Check out the [SpeakerDeck] [SpeakerDeck]!  You can also read the
[three] [feature flags part 1] [blog] [feature flags part 2]
[posts] [feature flags part 3] I wrote about feature flags.


<script async class="speakerdeck-embed" data-id="de78df307d8c0132f67712a273297520" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

In light of James Golick's recent untimely passing, here's a brief overview of [rollout](https://github.com/FetLife/rollout) and [degrade](https://github.com/jamesgolick/degrade), 2 gems which provide a simple interface for dynamic activation and deactivation of your app's features. We'll discuss why we might want to use feature flags and how to implement them using James' gems.

Links:

<!-- more -->

[https://github.com/jamesgolick/degrade/blob/master/lib/degrade.rb#L12-L20](https://github.com/jamesgolick/degrade/blob/master/lib/degrade.rb#L12-L20)
[https://news.ycombinator.com/item?id=8804624](https://news.ycombinator.com/item?id=8804624)
[https://medium.com/@benkaufman/remembering-james-golick-23c1dc3ab920](https://medium.com/@benkaufman/remembering-james-golick-23c1dc3ab920)
[https://medium.com/@jill380/the-adventurous-life-of-james-golick-bda4a33137b6](https://medium.com/@jill380/the-adventurous-life-of-james-golick-bda4a33137b6)

[SpeakerDeck]: https://speakerdeck.com/amcaplan/flag-your-features-with-rollout-and-degrade
[feature flags part 1]: /blog/2015/01/18/feature-flags-in-ruby-part-i-what-and-why/
[feature flags part 2]: /blog/2015/01/18/feature-flags-in-ruby-part-ii-how-and-where/
[feature flags part 3]: /blog/2015/01/19/feature-flags-in-ruby-part-iii-who-automate-feature-flipping/
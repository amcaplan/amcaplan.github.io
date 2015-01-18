---
author: amcaplan
comments: true
date: 2014-07-17 13:04:57 -0400
layout: post
slug: async-js-without-failing-capybara-tests
title: Asynchronous JavaScript - Without Failing Capybara Tests
categories:
- blog
tags:
- Experiences
- Programming
- Ruby
- JavaScript
- Capybara
---

Recently at work, I spent over a day trying to get one failing test to pass.  I tried everything in the code, but no dice.  Finally, I realized that the problem wasn't with my code - it was with the way Capybara works.  I want to save you the time I lost, so let's get to it.

Capybara, to quote its creator [Jonas Nicklas](https://github.com/jnicklas), "is ridiculously good at waiting for content."  It knows that when it's told to find something on the page, or click a link, and it's not there, don't sweat it - just keep trying until a default timeout (`Capybara.default_wait_time`) is hit.  When, and only when, that timeout is hit, Capybara will give you an `ElementNotFound` error.

This works great for most use cases.  However, sometimes it just isn't enough.  Let's illustrate with a real-world example.

<!-- More -->

### The Case

In my situation, we were working with [the `best_in_place` gem](https://github.com/bernat/best_in_place), a jQuery library which allows in-place editing of a model's attributes.  We were providing users with an Edit button which would turn the text into a textarea, and a Save button to save changes.

So we wrote a test where the text is edited once, saved, and then edited again.  The first time, no problems.  The second time, though, Capybara failed every time with an `ElementNotFound` error.  The textarea just wasn't there.  After lots of code changes, fancy debugging techniques, etc., the problem wasn't presenting itself.

Here's the issue, when we finally figured it out: We were replacing the element on the page after the AJAX call to update the model on the server successfully completed.  It turns out that `best_in_place` has a `data-activator` attribute, defining a DOM selector for the activator element (in this case, the Edit Button), which is used only once, when `$(editableElement).best_in_place()` is called.  This adds an event listener for a click on the activator.

When the element is replaced, then, we need to call `$(editableElement).best_in_place()` again to activate the activator (since the editable element, and the activator itself, have been replaced).  Failing to do so would mean that the item could be edited once, and never edited again!  There's our problem!

But wait - we *were* calling `$(editableElement).best_in_place()` again, and spinning up a Rails server showed that when I tried it in the browser, it all worked!  So what gives?

TL;DR (on the last few paragraphs) - everything was being done right, and Capybara was still failing.

### The Explanation

It turns out that Capybara is really good at waiting for an element to appear, but doesn't wait for elements to change.  So while `$(editableElement).best_in_place()` was still running, Capybara already clicked the element and moved on.  Not surprisingly, the element hadn't had the click handler bound to it yet, so the textarea never appeared.

The fix was a method introduced in Capybara 2 called `#synchronize`.  It's documented [here](http://rubydoc.info/github/jnicklas/capybara/Capybara/Node/Base:synchronize).  This is how I used it:
``` ruby
page.document.synchronize do
  element.find("a.edit-link").click
  textarea = element.find "textarea"
end
```
The call to `#synchronize` tells Capybara to run the block but catch certain errors, including an `ElementNotFound` error.  If there is an error, it will run the block again from the top.  So in this case when it fails to find the textarea, it will click the link again and see if the textarea appears this time.  This cycle will continue until the block completes without errors, or the global Capybara timeout is reached.

When I added the block, the test passed.  Presto!

### A Word of Caution

Before you go out and start using `#synchronize` all over your code, however, a warning is in order.  Capybara is really good at waiting for elements to appear, and waiting for AJAX has better solutions than `#synchronize`.  (See [the official Capybara documentation] for built-in functionality, and [this helpful Thoughtbot post] for how to avoid race conditions.)  So `#synchronize` is really for situations like this, where you have an element on the page which Capybara can find, but it takes a moment for it to gain the functionality you need - and, since Capybara browses way faster than you can, it interacts with that element just a bit too early.

The downside to `#synchronize` is that it introduces another point where Capybara tests can stall before failing, and it can mask a bad UX where JS that enables elements takes too long to work.  I'd generally recommend avoiding the use of `#synchronize` until you hit a wall and the existing Capybara magic doesn't quite cut it.  And if you do use `#synchronize`, open up the browser, and make sure the real-life UX is fast enough that your users don't hit some kind of unexpected behavior.

[the official Capybara documentation]:https://github.com/jnicklas/capybara#asynchronous-javascript-ajax-and-friends
[this helpful Thoughtbot post]:http://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara
---
author: amcaplan
comments: true
date: 2014-02-19 00:55:54+00:00
layout: post
slug: lessons-from-a-failed-successful-gem
title: Lessons from a Failed Successful Gem
wordpress_id: 8
categories:
- blog
tags:
- Experiences
- failure
- gems
- Ruby
---

One of our mottos at Flatiron is "Celebrate failure."  We aren't trying to get it right immediately - it's all about trying something, making it work, and then improving on it.

I recently published a Ruby Gem called CheckEverything (the source code is [here](http://github.com/amcaplan/check_everything) and the gem can be installed by typing '`gem install check_everything`' into your Bash console).

Over the course of creating this gem, I've made some mistakes, and learned a few lessons:

<!-- more -->

## 1. Abstract and Keep it DRY


This one I always knew, but it's more apparent from working on a larger project.  Make methods for any of three reasons:


a) Don't Repeat Yourself: don't unnecessarily write the same code multiple times
b) abstract to keep your code clean and understandable
c) reference values through a method so one change to the method will be reflected in many places in your code


I've learned that as methods get longer, they become less understandable and require more comments.  Names of helper methods essentially comment themselves, and add clarity to the method calling the helper method.

Having lots of methods is often helpful in debugging.  When you create a new method, or modify it, it is usually much easier to isolate where something went wrong.  You will often be able to figure out a few options for where the error is creeping in, and it's pretty easy to check the output of a particular method.  If they're well-named, you should be able to locate functionality quickly and perform a surgical strike on the problem.


## **2. Test Early and Test Often**


Tests are really important.  I'm going to say it again ten times to emphasize this.


<blockquote>Tests are really important.  Tests are really important.  Tests are really important.  Tests are really important.  Tests are really important.  Tests are really important.  Tests are really important.  Tests are really important.  Tests are really important.  Tests are really important.</blockquote>


Do we get the idea?  The point of testing is clear.  But to a novice programmer, the idea of testing frequently is far from obvious.  Here's why it makes sense to test ALL. THE. TIME.

Let's say you write a program that's 200 lines long, and then you test it.  You get this feedback as soon as you run it:


<blockquote>rub:200: syntax error, unexpected $end, expecting keyword_end</blockquote>


This is a major problem.  Sure, Ruby thinks the "end" is missing way down, but it turns out you have a block on line 36 that wasn't properly "end"ed.  And you probably first made the mistake because you didn't indent properly, so it will be impossible to find.

Let's say, however, that you were smart and tested every time you added a new method or made any significant (not necessarily major) modification.  That's great!  You'll have a narrow window to search for the problem, and you won't have to spend hours looking for the missing keyword.  (This is even more true in languages like Java where semicolons are required at the end of every line; finding that missing semicolon can be a nightmare.)

If your error is more complex, this is even more important.  In short:


<blockquote>Build up your program bit by bit, so you can understand what each part actually does - not just what you thought it would do.</blockquote>




## 3. Ruby Gems Rock!


If there's a complex task you want to perform, especially if it's a common need, search a bit and try to find out if there's a Ruby Gem that will take care of it for you.  I used [Nokogiri](http://nokogiri.org) to scrape the Ruby website for class names.  I probably could have done it on my own, but why bother, if Nokogiri does it for me?  A little practice with scraping, and it was fairly straightforward.

Luckily, the Ruby community seems to have taken up the [Principle of Least Astonishment](http://en.wikipedia.org/wiki/Principle_of_least_astonishment), so a good gem will hopefully be fairly easy to learn to use.  Invest a few minutes in checking out pre-existing tools before you decide to build your own.


## 4. Ruby Gems Aren't a Panacea


Unfortunately, there isn't a gem for everything.  So if you don't see a gem that you think should exist, make one!  Which brings me to...


## 5. Split Up Functionality!


If there's something in your gem that could be used in ways aside from what you want to do, split up the gem.  If you're publishing a gem for general use, divide the functionality into classes which can be used independently of each other.  Nokogiri is, I think, a fantastic example of this.  It includes multiple classes for parsing different file types.

On the other hand, if your gem is specialized, but some of the code could be used in a variety of ways, consider publishing 2 gems - one for the basic code, and one for your specialized program.  For example, let's say you are publishing a gem that finds pictures of cats online and turns them into pictures of exploding cats.  You can probably split up the gem into a PictureExploder gem which turns pictures into pictures of explosions, and a CatExploder gem which webcrawls for lolcats and invokes the PictureExploder class to turn them into explosions.  Then, if someone wants to make a TypewriterExploder gem to make exploding typewriter pictures, half the work is done already!

This of course leads to...


## 6. Be Open-Minded


Don't be afraid to change directions.  This is certainly true on the small scale, in terms of the "how" - the way your gem accomplishes its goal, the objects and methods and iterations.  However, it's also true in terms of the "what" - what your gem can accomplish.

Initially, I intended to write a gem that would store a user's favorite websites and launch them all with a single command.  (For example, ``check_everything morning`` would launch any website the user had included in the category 'morning'.)  Then I realized I could add much more practical functionality with a few additions:


a) scrape the Ruby website for class names
b) store the class names in a file that could be cross-checked
c) allow the user to input a Ruby class, recognize the class name, and spit out the website for that class


I then let things develop further, and at this point it will accept input like ``check_everything array#map`` and launch the page for that class, targeting the id associated with the method.

So at this point, it's a pretty awesome gem.  Now, here's the problem: I like having both of those features.  But a gem shouldn't really have that sort of dual functionality.  So the answer at this point is probably to split off into 2 gems, and possibly 3 if they share enough code.  Am I going to do it?  Maybe, maybe not.  After all, the Flatiron School is keeping me pretty busy.

But this problem is associated with tip #5 - splitting up functionality.  The more each function is separated, the easier it is to tease everything apart.  Luckily, thanks to tip #1 (abstracting), much of that has already been done.  Most of the code is either applicable to both Ruby Doc links and user-specific links, or has a separate method for each group where the logic diverges.  So when that task comes, it will be easier to do - just make 2 copies, and remove logic specific to each set of links from one or the other.  The hard part is going into shared methods that include logic for each set of links, but if that work is mostly done, the task shouldn't be impossible.

Finally...


## 7. Be Inspired!


I would really like to add another bit of functionality to my gem: you can choose to either launch the documentation, or just display it in your command line.  Unfortunately, there doesn't seem to be a gem that displays web pages.  So now I have a new dream: build a text-based browser written in Ruby!  At least sophisticated enough to display a page and then return to your previously running program.  (When?  I'm not sure, but I will need a lot of help!)

In short, while writing gems, you may discover a great idea for a gem that would be super-useful, and no one has done before.  Be bold!  Be that person who takes the next step!

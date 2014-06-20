---
author: amcaplan
comments: true
date: 2014-05-29 22:09:56+00:00
layout: post
slug: how-to-stay-classy-with-ruby-variables
title: How to Stay Classy With Ruby Variables
wordpress_id: 141
categories:
- Programming
- Ruby
tags:
- Ruby
- variables
---

Ruby provides a number of options for non-instance-specific variables - class variables (of the form: `@@var`), constants (in all caps: `VAR`), and class instance variables (`@var`).  Which one to use depends on the use case, and to some degree on personal preference.  Let's explore this a bit.

Constants are meant to be - well, constant.  This is not technically enforced in Ruby; if you redefine a constant during program execution, it will display a warning, but not actually raise an error.  However, the semantic idea of a constant is that it should be defined once and not touched again. Variables, on the other hand, are variable.  They record a particular state that is likely to be redefined at some future point in time.

Now let's examine some use cases and see where things start to get tricky.  To make things fun, let's go to the zoo! In this case, I have an `Animal` class, which will be at the top of the hierarchy and have animal classes that descend from it.  Here are my requirements:


1) Since most of my animals are quadrupeds, I decide it makes sense for the class's instances to default to 4 legs, and any subclass (let's say `Octopus`) with a difference number of legs should change the default.




2) Both the `Animal` class and the individual animal-type classes should keep track of how many of each type of animal exists, so I can check `Animal.all` or `Octopus.all`.


Let's get to work.  Following Sandi Metz's recommendation, we're going to build an `Animal` parent class with a post-initialization hook.  Hence, the `Animal` class's initialize method will append the new item to an animals array, and then call an `after_initialize` method which will be accessible to the child classes.  We'll start with just 2 animal types, octopus and llama:

<script src="https://gist.github.com/amcaplan/47ed2d92e8f95a82e99b.js"></script>

Hmmmmmm, not exactly what we wanted.  How did we end up with an 8-legged llama?


[![8-legged llama](http://amcaplan.files.wordpress.com/2014/05/8legllamab.jpg?w=245)](https://amcaplan.files.wordpress.com/2014/05/8legllamab.jpg)




Well, it turns out that Ruby class variables don't play very nicely with inheritance.  Essentially, they are shared by any class in an inheritance chain.  So when we defined `@@legs` in `Octopus`, it changed `@@legs` in `Animal` and, by extension, `@@legs` in `Llama`.  (Technically, if `Animal` doesn't define a class variable, `Llama` and `Octopus` won't share that variable.  But going down that path is just begging for trouble, because you never know when someone down the road will add `@@legs` to Animal and open up a huge can of worms.)  I have heard this described as "leaky inheritance," though I have yet to see it in writing.




Class variables, it seems, are really best for situations when you want to have each member of an inheritance hierarchy to be able to access the same variable.  That might be useful for configuration.  For example, let's say each animal has a speak method which it defines, and it can speak verbosely or concisely (for a `Dog`, "WOOF!  WOOF WOOF WOOF!" vs "WOOF!").  Perhaps we want to change one setting in `Animal` and have that apply to all animals.  In that case, we would do something like this (irrelevant code removed for now):




<script src="https://gist.github.com/amcaplan/894910bc4036581aa10a.js"></script>




So that works great.  But we need to do something about `@@legs`.  So here's the next option, which works well.  Let's change `@@legs` to a constant, `LEGS`:




<script src="https://gist.github.com/amcaplan/4eb569ccee73fd3bb5ba.js"></script>




_Note how we now access `LEGS` as `self.class::LEGS`.  This is critical.  If we accessed it as `LEGS` without adding `self.class::`, we would be referencing the `LEGS` variable in the scope where the method was defined, i.e. `Animal`.  Instead, we tell the method to reference `LEGS` as it is defined within the scope of the current class._




Alright, we've taken care of legs, but let's consider another issue.  What about our tallying object?  Right now, `Animal` has an `@@animals` variable which contains all the animals in our zoo.  This presents 2 problems:




1) What if a later programmer decides to call the container `@@animals` in the `Elephant` class?  Suddenly we've entered a world of hurt.




2) On a more fundamental level - does it make sense for `Octopus` to have access to `@@animals`, even theoretically?  It should be blissfully unaware of the `Lion`s and `Tiger`s and `Bear`s throughout the zoo, and just know about the 8-legged ocean critters.  How can we make this happen?




We can solve problem 1 by simply replacing the array `@@animals` with a constant, `ANIMALS`.  Hence, subclasses that define their own array of animals won't generate a conflict.  However, despite seeing others advocate for it, I don't like that solution either, for 3 reasons:




1) Now we have a different problem.  If the designer of the `Elephant` class neglects to define an `ANIMALS` constant but still adds to the `ANIMALS` array, the parent class's array will be affected.  This may be difficult to debug.




2) It's true that Ruby doesn't complain about changing the contents of a constant array, because the object hasn't been fundamentally redefined.  That doesn't mean it's the right thing to do.  Others will disagree (and in fact Rails apparently does this all the time), but I maintain that constants should be constant and predictable.




3) Constants are easily accessible from outside the class.  Now, I know that everything in Ruby, even private methods, is accessible, but there's a semantic point here.  Where in the Ruby core classes do you find constants?  My first thought is in the `Math` module, which contains the constants `PI` and `E`.  In other words, constants are meant to be values which are definitional to the class and/or should never change once defined.  `PI` and `E` are not going anywhere.  Similarly, it makes sense to say that `Llama::LEGS` is 4 and `Octopus::LEGS` is 8, since those are attributes that should apply in all but the most exceptional cases.  (My apologies to Larry the 3-legged llama.)




The animals array, on the other hand, is not at all fundamental.  It's a variable that is changed frequently, and should be associated with the class, but not easily accessible from outside, and not shared with subclasses.




So what's the right answer?  Well, let's remind ourselves for a moment that everything in Ruby is an object.  It turns out that even classes are objects - instances of the `Class` class.  (Sidebar: if you want to really warp your brain, enter `Class.class` into IRB.  Yep, `Class` is an instance of itself!  Mind blown.)  So if classes are instances, surely they have instance variables, right?  Yes, they do.  And we can use them to implement a safe working version of our animals array!




<script src="https://gist.github.com/amcaplan/a83d917476be44daaeff.js"></script>




Note that this was a bit tricky.  We had to define a getter method for the animals array.  If we have a number of such variables, we would probably be best off using `attr_accessor`, but the call to `attr_accessor` has to be within the context of a `class << self ... end` (singleton class) block.




On the other hand, we've essentially established the animal-tracking system in the parent class, and we can take advantage of it in children by giving each its own `@animals` array as a class instance variable.




Alright, dear readers.  The time has come to leave you with the final, comprehensive version of our zoo.  Just don't feed the animals!




<script src="https://gist.github.com/amcaplan/992b11955e20a05c26ab.js"></script>




As always, comments and thoughts are most welcome.  Stay classy, Rubyists!

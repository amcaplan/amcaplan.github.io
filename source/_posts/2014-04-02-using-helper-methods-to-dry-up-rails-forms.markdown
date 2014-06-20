---
author: amcaplan
comments: true
date: 2014-04-02 04:59:32+00:00
layout: post
slug: using-helper-methods-to-dry-up-rails-forms
title: Using Helper Methods to DRY Up Rails Forms
wordpress_id: 113
---

Helpers are a pretty nifty feature of Rails. And I'm not just talking about the built-in form helpers and the like, though those are awesome. I'm talking about the fact that you can custom-build your own helper methods to clean up repetitive content. Building your own helpers can be a bit tricky, though, so let's first review a basic Rails rule that is likely to trip you up. Here are some things Rails doesn't like:



	
  1. &lt;

	
  2. &gt;


Yup, Rails isn't a big fan of HTML markup, unless it's generated directly from the HTML in a view, or by one of the built-in Rails helper methods.

No, no, don't get angry at Rails!!!  It's for your own good, to make sure that you don't accidentally run some sort of evil, malicious script that a user input into a form or submitted in some other way.

<!-- more -->

Luckily, Rails has a method called `raw` which will convert a String into an ActiveSupport::SafeBuffer object (this is the equivalent of typing `"string-contents".html_safe`).  The object is marked such that Rails knows not to escape its contents.  (See [Henning Koch's explanation](http://makandracards.com/makandra/2579-everything-you-know-about-html_safe-is-wrong) for more details.)

So this makes sense so far.  And now we understand how Rails's built-in helpers don't have the HTML-escaping problem: they mark their contents as HTML-safe.

Bottom line of Part 1: You can use `raw("string")` to allow unescaped HTML into your view.  But make sure there's nothing in the String that's input by the user.  If there's a piece that needs sanitizing but the rest needs to be raw to work, first `sanitize("user input")` and then `raw("<HTML-element>sanitized user input</HTML-element>")`.  Another method that may occasionally come in handy is `escape_once("html stuff")`, which will recognize sanitized pieces and not sanitize them again, but will sanitize the rest.  Hence, `&amp;` won't end up multiplied to `&amp;amp;` (because, y'know, we've all been there).

OK, so now you know how to make sure the right strings, and only the right strings, are sanitized.  But when are custom helpers going to actually be useful in putting together a page?

I recently refactored a project I've been working on, to try DRYing up my code using custom helpers.  I found 3 major benefits:



	
  1. Write less code

	
  2. Avoid repeating class assignments

	
  3. Easier standardization of the look of the page


The first is pretty straightforward. More code lumped into a single method call means less code overall. The second is a matter of making it easier for the developer to change the classes of lots of DOM elements just by modifying the helper. The third is the result for the user: a page which, by repeatedly calling on a single helper method, is more likely to have elements that properly resemble each other.

Let's illustrate with a couple of examples. In the first, we have a form with a bunch of tabs. I wanted to consolidate the code for the tabs, because there's lots of repeating pieces. Here's what I did:

<script src="https://gist.github.com/amcaplan/6abca8b624e062938ead.js"></script>

became

<script src="https://gist.github.com/amcaplan/fe6e47b5d774d4833da2.js"></script>

using the helper method

<script src="https://gist.github.com/amcaplan/4c382886cc1e67904291.js"></script>

Now let's break it down. I used `content_tag`, which takes 3 arguments: tag type (`div` in this case), content (render etc.), and an options hash. It generates a string of HTML that fits the criteria and marks off the contents as HTML-safe. Hence, I don't have to `raw` it. I also didn't have to call `raw` on the second argument, since `render` also returns an ActiveSupport::SafeBuffer object.

One could argue that the short form is less semantic than the long form. In truth, I'm inclined to agree. I grew up on HTML, and it looks much cleaner to my eyes than using the helper. However, I have to admit that using the helper makes it less likely for elements to end up differing from each other in ways that could break the layout or cause a JavaScript bug. Ultimately, I'm not sure there's one right answer. But it's good to be aware of multiple tools, and actively choose between them.

Here's another example, from one of the partials of the above form, where the user chooses guests to invite. Here's the original code:

<script src="https://gist.github.com/amcaplan/698d2c5258d0b3980be9.js"></script>

The modified code:

<script src="https://gist.github.com/amcaplan/d34f0b701ffa566c15dc.js"></script>

And the helper method, also in MealsHelper:

<script src="https://gist.github.com/amcaplan/e92498fb5f59b584f9fe.js"></script>

What's happening here is a little complicated, so let's isolate one case:

``` erb    
<div class="medium-4 small-12 columns">
  Name: <%= ff.text_field :name, name: "person[][name]" %>
</div>
```



turns into

``` erb
<%= person_field("Name:#{ff.text_field :name, name: "person[][name]"}") %>
```

So we've assumed each person_field will have a bunch of the same classes (for CSS purposes), and just isolate the unique things for each field.  The helper method fills in the classes.  This way, if I ever want to change the look of the person fields, I have one address to do it from!

Also note that the method takes the block and passes it in as the final parameter to `content_tag`.  This is a built-in feature of `content_tag` - it will take a string or a block and stick whichever one between the tags it builds.  Hence, in the last form element (relationship), the method gets a block rather than a string, and it works just fine.

One final useful note: look at line 17 of the updated version.  See `tag(:hr)`?  That's another helper offered by Rails, and it totally beats the alternative: `raw("<hr>")`.  It's nice to not have to raw things up.  Whether you love or hate view helpers, it's still important to recognize and know how to use the built-in helper methods, because they will come in handy in plain old views for avoiding the problems caused by Rails' automatic sanitization.

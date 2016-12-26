---
layout: post
title: "Git Commit Message Anti-Patterns"
date: 2016-12-26 13:11:32 +0300
comments: true
categories:
- blog
twitter:
  description: Do your coworkers secretly hate your commit messages? Recognizing
    these 5 anti-patterns will help you hone the art of the commit.
---

Have you ever experienced this before?  You've just finished a unit of work, and
you're rightfully proud of what you've accomplished.  All that's left is to
commit and push.  So let's just `git commit -am "`... what exactly?  Filling in
that line can be really tricky, and you never know when another developer—or
future you—will curse your name for an unhelpful commit message.

Fortunately, many common harmful practices can be summed up into a few
anti-patterns.  In this post, we'll cover 5 critical mistakes to avoid.

<!-- more -->

### 1. The One-Liner

One of the most common mistakes programmers make (not just junior developers!)
is overuse of the `-m` flag.  It's awfully convenient to write out your message
on the command line, never having to drop into Vim to edit a commit message.

Unfortunately, `-m` also means you can't (easily) write a multi-line commit.
Often, a multi-line commit is the perfect place to add a comment about why a
decision was made, the business purpose of a feature, or how something performs
(you can even include benchmarks!).  When commits are viewed in the short form,
only the first line will show up, but if someone dives deeper into that commit,
they'll find all the juicy stuff you left for them.  And if you make multi-line
commits a regular practice, you'll find that the team starts looking for them
more and more, further increasing their value.

If you don't like using Vim, guess what?  You don't have to!  Just set the
`$GIT_EDITOR` bash variable in your `.bash_profile` and you can switch it to
any editor you want.  I'm partial to MacVim, so I've set:

```sh
export GIT_EDITOR="mvim +star -f"
```

to start MacVim in Insert mode.  You can add whatever command line flags you
wish to really customize your git editor.

I've also aliased `gc` to `git commit -v`, which prints out a diff in my text
editor below the message area.  It's not included in the message, just for me to
see while I'm writing.  This way, I have a quick opportunity to look over all my
changes and make sure my message properly reflects what changed in this commit.

### 2. The File List

Commits are often headlined with `Update file.rb and other_file.js`.  This
misses the point of a commit.

If I want to know what files were updated in a commit, I'll dive deeper with
`git show`.  The commit tagline serves a different purpose: explaining the
semantic nature of your changes.

Consider this git history:

```
db68160 Add _posts/talks/2016-05-05-this-is-your-brain-on-ruby.markdown (Ariel Caplan, 3 months ago)
42adaf2 Add _posts/talks/2015-11-06-start-your-rails-engines.markdown (Ariel Caplan, 3 months ago)
2c2d151 Add source/railsconf2016/index.html and PDF (Ariel Caplan, 4 months ago)
28b958f Remove source/_includes/asides/github.html and edit layout files (Ariel Caplan, 6 months ago)
9e09be5 Edit _posts/talks/2015-11-24-threads-and-processes.markdown (Ariel Caplan, 6 months ago)
```

Now consider this:

```
db68160 Add This Is Your Brain on Ruby as a talk (Ariel Caplan, 3 months ago)
42adaf2 Add RailsConf Rails Engines workshop as a talk (Ariel Caplan, 3 months ago)
2c2d151 Add RailsConf2016 slides (Ariel Caplan, 4 months ago)
28b958f Remove GitHub repos aside (Ariel Caplan, 6 months ago)
9e09be5 Add video for RailsIsrael talk (Ariel Caplan, 6 months ago)
```

Which one tells a more coherent story, months or years later?  And keep in mind,
this is just for a blog with a bunch of unrelated posts; now think about an
application which has a nontrivial history of interrelated commits.

Making the point differently, the file list tells the How, but your commit
history is about telling the What: What happened to this repo over the course of
time?  How has it changed and developed?

### 3. Bugfix

Very often we justify a quick "Bugfix" commit message with the thought that it's
just a bugfix so it's not important.  That could not be further from the truth!

A bug is no more or less than an application doing exactly what you told it to
do.  The problem is always that you told it to do something different than you
really had in mind.  Fixing a bug is a change in behavior; it deserves to be
documented appropriately in your commit message.

What was the incorrect behavior you observed?  How does your change address it?
What steps did you take to ensure the bug won't happen again: Extra tests, a
guard clause, a refactor to avoid the problem?  All of this is useful
information when you need to revisit that code.

### 4. "It was the best of times, it was the worst of times..."

This tip is simple: Keep it short!

It's definitely important to go into detail in your commit messages.  But the
one-line summary isn't the place for it.  Make sure your first line is no more
or less detailed than necessary, and then expand to your heart's content in the
following lines.

[Tim Pope recommends][Tim Pope recommends] that you keep the first line below 50
characters.  I stretch that limit on occasion, but it's a decent rule of thumb.

Keep in mind, when you run `git log`, you'll be reading the messages on your
screen in a big wall of text.  Make sure the important words pop out (capitalize
appropriately!) and don't create more visual noise than necessary.  As
Shakespeare wrote, "Brevity is the soul of wit."

To get to the point: You have 1 line to work with, so get to the point!

### 5. ABC123

This one might be a little controversial, but hear me out.

Some shops might have a convention of prefacing a commit message with a ticket
number:

```
[ABC123] Implement admin workflow for comments
```

This might seem like a good idea.  However, keep in mind that it adds
significant noise to the commit message and removes focus from the substance of
the commit, all while impinging on your precious 50 characters.

More importantly, the ticket number is helpful for searching, but not for
eyeballing.  The one-liner's main goal should be to quickly run through history
and figure out what to focus on.  Once you spot the commit you want, you can
dive into details.  At that point, information like ticket number is useful—and
that's why you have the remainder of your commit message.

My personal preference is to always include the ticket number in the branch name
and pull request title, and to always merge the pull request with a merge
commit.  That way, the commit messages are broken into chunks, bracketed by pull
request titles which sum up the last few commits and link them to a ticket.  So
instead of:

```
db68160 [ABC123] Implement admin workflow for comments (Ariel Caplan, 3 months ago)
42adaf2 [ABC123] Moderate comments by default (Ariel Caplan, 3 months ago)
2c2d151 [ABC123] Filter comments for spam (Ariel Caplan, 4 months ago)
28b958f [ABC123] Add comments support to posts (Ariel Caplan, 4 months ago)
0827ed1 [ABC121] Replace hero image with cooler ninja (Ariel Caplan, 4 months ago)
dae8999 [ABC121] Darken post background (Ariel Caplan, 4 months ago)
```

we might see this instead:

```
9e09be5 Merge pull request #478 from 'ABC123-add-comment-support-to-posts' (Ariel Caplan, 3 months ago)
db68160 Implement admin workflow for comments (Ariel Caplan, 3 months ago)
42adaf2 Moderate comments by default (Ariel Caplan, 3 months ago)
2c2d151 Filter comments for spam (Ariel Caplan, 4 months ago)
28b958f Add comments support to posts (Ariel Caplan, 4 months ago)
a713ef2 Merge pull request #477 from 'ABC121-make-post-template-cooler' (Ariel Caplan, 3 months ago)
0827ed1 Replace hero image with cooler ninja (Ariel Caplan, 4 months ago)
dae8999 Darken post background (Ariel Caplan, 4 months ago)
```

In this case, I can clearly see which set of commits corresponds to which pull
request, which then links a set of several commits with a ticket as a unit of
work done.  YMMV, but I find this to be an incredibly helpful way of figuring
out how individual commits fit into a sequence without compromising on the
limited first-line space.

Of course, to make this work, you probably want to ensure your pull requests are
rebased off your main branch just before merging. Otherwise, your commits end up
in a big jumble and it's harder to make sense of things. Regardless of whether
you follow my suggestion in terms of ticket numbers, I consider it a best
practice to make sure related commits are grouped linearly in your Git history.
It will save you a lot of confusion in the long run.

### Parting Thoughts

This might seem like a lot of nitpicking for not a lot of value. In truth, I
can't guarantee immediate results because there won't be any. It takes time, and
the cooperation of a full team, to make the most of good Git commit practices.
I can, however, attest to these practices having saved me countless hours in
figuring out what happened in the past, why decisions were made, and even just
the basics of which code additions and changes are interrelated.

I will close with one thought: Whatever your decisions, you only get one
chance<sup>1</sup> to write history. Make it count.

<hr />

<sup>1</sup>With Git, technically you can rewrite history whenever you want, but of
course practically it doesn't happen past a few commits.

[Tim Pope recommends]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

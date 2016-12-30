---
layout: post
title: "Make It Easy to Do the Right Thing"
date: 2016-12-30 12:53:38 +0200
comments: true
categories:
- blog
twitter:
  description: |
    There's one small trick that makes it far easier to act the way you should:
    Reduce the cost of doing it right.
---

There's a great Kent Beck quote which should be etched on the mind of every
serious programmer:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">for each desired change, make the change easy (warning: this may be hard), then make the easy change</p>&mdash; Kent Beck (@KentBeck) <a href="https://twitter.com/KentBeck/status/250733358307500032">September 25, 2012</a></blockquote>

The immediate context of the quote is changing code.  But truth be told, it
actually applies to a whole host of problems on multiple levels.  It can help us
fundamentally alter our practices, our teams, and all elements of the quality of
our software.

Let's understand how and why.

<!-- more -->

### The Chemistry of Change

Let's begin with a metaphor from the world of chemistry.  Any chemical reaction
is bound by activation energy, the minimum amount of energy which must be
available in the environment for it to proceed.  Even if the result is a
lower-energy, higher-entropy configuration (a fancy way to say the universe will
be happier after the reaction), the activation barrier must be surmounted in
order for the reaction to proceed.

A catalyst is nothing more or less than an entity which lowers the activation
barrier.  Here's a diagram of how a catalyst works:

![Activation energy](/images/activation_energy.svg)

The right side represents the higher-energy (i.e., not preferred) state, while
the left side is the lower-energy (stabler) state.  To cross from one to the
other, there must be enough energy available to cross the peak in the center.  A
catalyst lowers the activation barrier such that we only need enough energy to
conquer the smaller, red-dotted peak.

Also note that the activation barrier looks different from the two sides.  From
the right side, it's decently high, unless a catalyst is present.  From the
left, stabler side, it's really tall even with the catalyst there.  This is why
the form on the left side is likely to stick around.

Now let's apply all this to programming practices.  The right represents a bad,
or less-than-optimal practice, you currently employ.  The left represents a
better way of doing things.  It's stabler - it will yield better software that
will make you happier.

If you want to transition from the worse practice to the better one, you have 2
issues to consider:

1. What's the barrier to adopting the new practice?
2. How much value does the new practice provide?

By lowering the barrier, and maximizing the value—or lowering the cost—of a good
practice, you'll help yourself and others adopt the right practice and stick
with it.  Let's give some examples of how this works on a number of levels.

### Bash Shortcuts for Better Git Usage

Whatever shell you use, you get a configuration file with the opportunity to
define aliases and functions.  Rather than giving general principles, I'll point
to a few concrete things I've done to encourage myself to do the right thing.

Sometimes a simple alias is enough.  One of my favorite aliases is

```sh
alias gc="git commit -v"
```

Short and sweet.  Instead of typing out `git commit`, I just type 2 characters
and I'm ready to go.  But that comes with a distinct advantage.  The `-v` flag
shows a diff of the commit, so I have all the changes fresh in my mind as I
write a commit message, and end up writing a clearer message.  Sometimes I'll
see the diff and rethink my decision to commit the current set of changes; it's
a chance to give one last audit to the commit contents themselves.

Here's another great git alias:

```sh
alias gap="git add -p"
```

Instead of adding whole files, you can use `-p` to visually inspect every change
and only include changes to certain lines in one commit, saving other changes
for later.  By aliasing the `-p` version of `git add`, I've made the `-p` option
more attractive than typing out `git add filename`, or even worse, `git add .`.
I have caught a significant number of mistakes (often leaving in a `binding.pry`
call!) this way.

Here's another.  Ever been tempted to `git push --force`?  OK, that was a funny
joke.  Not only have you been tempted, you've probably done it in the past hour,
despite knowing it's fraught with danger.

There's a better way, though: `--force-with-lease`.  It works like `--force`,
but backs out if your changes would overwrite someone else's changes.  Once
`--force-with-lease` exists, there's not usually a good reason to `push --force`
except for the fact that it's so much less typing.

Problem solved!

```sh
alias gpf="git push --force-with-lease"
```

Bash shortcuts lower the activation energy by reducing the friction involved in
remembering and adding particular flags and options.  They also make the better
practice stabler by lowering the long-term cost of sticking with it.

### Bash Shortcuts for Healthier Development Practices

One line I'll frequently write into my terminal won't make any sense to you:

```sh
gup && safely prom
```

This line will update a branch with the most current version of the `master`
branch on GitHub, run a build locally, and if everything still goes green,
initiate a pull request.

`gup` is (in my brain) short for "git update", and is aliased to:

```sh
git fetch origin master:master && git rebase master
```

That pulls the latest `master` from GitHub into my local `master` branch, then
rebases the current branch off of master.  The goal is to ensure that I don't
submit a pull request before making sure I'm working with the most updated
version of the code, in case recent changes conflict with something I changed.

Next is `safely`.  This is a quick'n'dirty shell function:

```sh
function safely() {
  drspec && cop && "$@"
}
```

Hmmm, those don't really make sense either, because they also break down into
shortcuts:

```sh
function drspec() {
  docker-compose run web bundle exec rspec "$@"
}

alias cop="docker-compose run web bundle exec rubocop --rails --fail-level autocorrect"
```

Let's take it from the top.  We run our apps as sets of containers, which need
to be run with `docker-compose`.  We run the `web` container to run our tests,
and the actual command is `bundle exec rspec` followed by whatever arguments we
passed `drspec`.  (`"$@"` just passes on the arguments passed to our function.
So if we ran `drspec spec/models/user_spec.rb --fail-fast`, that would equate to
`docker-compose run web bundle exec rspec spec/models/user_spec.rb --fail-fast`.)

Next is `cop`, which launches a container to run Rubocop with a bunch of options.

Going up a level, `safely` just runs those 2, then executes whatever you passed
it, short-circuiting if any of the checks fail (hence the name `safely`).
Finally, we have `prom`:

```sh
function pro() {
  pr_url=$(hub pull-request -b $1)
  if [[ $? == 0 ]]; then
    open $pr_url
  fi
}

function prom() { pro master; }
```

`prom` uses [GitHub's `hub` tool](https://hub.github.com) to open a pull request
against the `master` branch.

Ultimately, here's what I wrote:

```sh
gup && safely prom
```

And here's what happened:

```sh
git fetch origin master:master && git rebase master && \
  docker-compose run web bundle exec rspec && \
  docker-compose run web bundle exec rubocop --rails --fail-level autocorrect && \
  hub pull-request -b master
# After this I'd have to highlight the output from hub, open the browser, and
# paste the URL, to check everything worked. The bash function does that for me.
```

No way am I going to type all that every time!  It's sorely tempting to just
open a pull request and hope for the best, but that wastes CI resources, and if
I broke something badly, I just wasted other people's time.  By setting up a few
bash shortcuts, I make it easy to set the process in motion, go off and do
something else, and come back in a few minutes to make sure it completed
properly.

It's also worth noting that `drspec` is pretty valuable on its own.  It's not so
much for the time saved, but more because if testing requires a lot of typing,
it may not happen nearly as frequently as it should.  Some use `guard` to solve
this problem by running tests automatically without typing at all.

### Making Things Faster

If you ask people why they don't run their tests more frequently, 9 times out of
10 they'll say it's because it takes too long.  They want to run their tests
more regularly throughout the development process, but the overhead of a single
run is too much of a break in development to apparently justify the time sink.

Many things work the same way.  We want to change our ways, but the cost of
doing things the better way is too high.  We can often lower the cost by making
things faster.  This isn't the place to talk about speeding up tests (that's
worth a post in itself), but I'll give a simpler example.

As mentioned previously, I work with a containerized app.  We use
`bundle package` to package the gems in the Gemfile into the app directory, then
copy them over to the container image amongst everything else in the Rails root.
This means that any gem updates require rebuilding the container image.
Building the image used to take about 10 minutes, certainly enough time to
totally distract you from whatever you were doing.  This, in turn, meant we were
unlikely to upgrade gems as we go, because the subsequent container rebuild was
a time-consuming process.

I recently dug in to figure out what was taking so long.  It turns out that we
copy every file and then change the ownership from the root user to the
application's user.  Copying followed by `chown`ing was taking the vast majority
of time.  I discovered that not only were we copying app code, we also copied
over every file in the `.git` directory!  Since git produces a lot of files, we
had an ever-increasing amount of `chown`ing to do.  I learned that I can exclude
`.git` from the copy operation using a `.dockerignore` file, and that brought
down build time from 10 minutes to 3.

3 minutes is still a lot of time, but it's low enough that upgrading gems is
less of a hassle.  And lowering that activation barrier means we're more likely
to keep our gems current.

### Opening Up the Option

As I stated in the intro, there are many types of problem you can solve by
thinking about activation barriers.  Here's an example of solving a people
problem in this way.

On my team, we believe strongly in the value of pair programming, but we often
have a difficult time actually making it happen.  We're a distributed team with
a chat-heavy culture, and even when pairing seems to be a good idea, it often
fails to materialize.

Recently we made some changes to the way we work, and I pushed hard to have a
daily standup on video chat.  One major motivation was to open up the option of
pairing.  If we already see each other face to face, there's a much lower
activation barrier to saying, "Hey, this is a difficult task.  Can you help me
out with it?"  Or perhaps more importantly, "Oh, I didn't know you were working
on that.  Maybe I can pair with you on it?  I want to learn more."

Another example of this type of thinking is having regular retrospectives.
Everyone wants to improve the team, but feedback loops don't tend to open
themselves up.  It's critical to create opportunities for team members to give
feedback without having to demand to be heard.  (The same applies to 1-on-1
employee-manager meetings, too.)  To lower the barrier even more, you can take
steps to make sure people feel safe giving honest feedback, such as using a tool
that anonymizes the identity of the person giving feedback.

### Temporary Constraints

I'm not going to talk about this too much, since I already developed this idea
at length in [another post](/blog/2016/01/04/choose-your-constraints/).  You can
constrain yourself to follow certain practices, train yourself to become more
comfortable with them, and in the long run adopt the practices happily.  Here,
rather than focusing on the activation barrier, you accept that it will be
difficult to change.  But the commitment means you increase the value and
decrease the cost such that it's eventually more difficult to go back.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Your current constraints ultimately train you to operate effectively within precisely those constraints. Choose your constraints wisely.</p>&mdash; Ariel Caplan (@amcaplan) <a href="https://twitter.com/amcaplan/status/670030185106907136">November 27, 2015</a></blockquote>

<blockquote class="twitter-tweet" data-lang="en" data-conversation="none"><p lang="en" dir="ltr">Always make time for testing, pairing, knowledge sharing, and learning. Eventually they will happen automatically without special effort.</p>&mdash; Ariel Caplan (@amcaplan) <a href="https://twitter.com/amcaplan/status/670031382144528385">November 27, 2015</a></blockquote>

Some of the best practices actually cost very little, once you become
comfortable with them.  When it comes to TDD, for example, I struggled a lot at
the beginning, but now I develop more quickly in a TDD workflow than when I try
to test afterwards.  It took practice and discipline to get here, but at this
point I'd have to work hard to go back, and that's exactly the point.

Figure out what major change you want to make to your practices, and commit to
it wholeheartedly.  Think about how to adopt the practice with the least
possible disturbance to your workflow, and reevaluate as you go.  Eventually you
should find that your standard workflow has come to encompass this practice, at
little to no extra cost.

### If You Make the Change Easy, They Will Come

Any self-aware programmer or team tries to be conscious of its shortcomings and
work on improving them.  Often we make a mistake in trying just to push
ourselves to do better.  Instead, we might be better off focusing on lowering
barriers to improvement.  If it's just as easy to do the right thing, we'll find
ourselves doing it more and more, and improvement will happen without adding
unnecessary stress.

We are often encouraged to be catalysts for change.  It's worth remembering what
a catalyst is.  A catalyst doesn't push or prod or apply pressure.  Instead, it
lowers a barrier and enables change to happen.

The same is true for changing our teams.  You can't force others to do things
your way.  But you can serve as a catalyst, removing obstacles while helping
them to understand the value your suggested change will provide.  If the change
is legitimately valuable and the team is open-minded, usually they'll come
around.

***Written as part of the 2016 [8 Crazy Blog Posts Challenge](../../25/8-crazy-blog-posts).***

---
layout: post
title: "Formulating the Ethics of Programming"
date: 2015-11-18 15:42:16 +0200
comments: true
categories:
- blog
twitter:
  description: Uncle Bob just published a Programmer's Oath. I think there is
    some room for improvement.
---

[Uncle Bob][Uncle Bob] recently published a [post][A Programmer's Oath] where he
attempted to formulate the ethical principles that should guide programmers.  It
was an interesting concept, but I immediately felt it could use a rewrite.

Although I agree that everything in his version is a good idea, I disagree with
the formulation as an ethical guideline for programmers.  Simply put, the
principles of Agile are brilliant.  But they hardly deserve mention in a list of
ethics, and - I would contend - detract from the list.

<!-- more -->

There are most certainly cases where following Agile practices would be the
unethical thing to do; it all depends on the needs and policies of the client or
company.  For example, consider Principle 5:

> I will fearlessly and relentlessly improve the code at every opportunity. I
will never make the code worse.

Sometimes, what's needed is a quick fix for production, followed by a more
well-thought-out solution that will take some time to produce.  Will that make
the code worse in the meantime?  You betcha.  Is it the right thing to do
anyway?  Very likely.

Let's consider Principle 7:

> I will continuously ensure that others can cover for me, and that I can cover
for them.

Again, I totally agree.  But if there are 2 developers in a tiny, bootstrapped
startup, maybe you don't have enough time to share all the information all the
time.  Principle 7 is true for most business cases.  But as soon as it's
specific to a business case, you can tell that this is less of a moral principle
and more of a strategy for success in accomplishing something else.

In both cases, the principles are really ways of - in the average business case
- helping the employer/client to be more stable and able to continually improve
its product.  So when it comes to the ethical piece, these principles - in fact,
at least half of the oath - boils down to:

> I will be an honest employee or contract worker, making sincere effort to
produce value for those who pay the bills, in both the short and long term.

That's a statement of ethics, and it might belong in a programmer's oath.

Thinking about it further, I came up with my own version of the programmer's
oath, heavily based on the [version][Modern Hippocratic Oath] of the Hippocratic
Oath currently used in many medical schools.  I was honestly surprised at how
much could be lightly edited and incorporated into a programmer's oath.  There
is a comforting universality to ethics.

Let me know your thoughts!

> I swear to fulfill, to the best of my ability and judgment, this covenant:
>
> 1. I appreciate the work of past generations, who overcame hardware and software limitations to produce the programming environment of today, and I will collaborate with colleagues in the present to further improve the future of our trade.  I recognize that I have received instruction from those who preceded me, and I will repay in kind by sharing my knowledge with those who will follow.
>
> 1. I will strive to efficiently produce the solution which best fits the needs as best as I can perceive them.  I will not shortchange through either overengineering or underdesigning.  I will provide verification, to whatever degree is reasonable given constraints of time and finances, that the solution I have generated works as expected.
>
> 1. I will treat clients and coworkers with respect and warmth.  I will listen to their ideas, using their input to sharpen my own understanding.  When disagreement arises, I will collaborate with the other parties to reach mutual understanding and agreement.  I will never reject or insult anyone I work with.
>
> 1. I will not be afraid to say "I don't know" and I will respect others for their admission of the same.  I will not be afraid to ask questions.
>
> 1. I will never attempt to deceive those who rely on my honesty.
>
> 1. I will respect the privacy of my company and/or clients, barring unethical or illegal behavior on their part.
>
> 1. I take full and complete responsibility for the ethical implications of every line of code I write.  I will value the guidance of my own moral conscience above my company's or client's desire for profit.
>
> 1. I will remember at all times that all of my code will interact with people; it will influence the lives of human beings.
>
> 1. When the problem is people, rather than code, I will address the people problem directly, rather than incurring the technical debt of excess code.
>
> 1. I will always consider myself a regular member of society with access to extra information and power.  My skills give me no right to exert greater influence on other human beings.

[Uncle Bob]: https://en.wikipedia.org/wiki/Robert_Cecil_Martin
[A Programmer's Oath]: http://blog.cleancoder.com/uncle-bob/2015/11/18/TheProgrammersOath.html
[Modern Hippocratic Oath]: https://en.wikipedia.org/w/index.php?title=Hippocratic_Oath&oldid=688739951#Modern_version

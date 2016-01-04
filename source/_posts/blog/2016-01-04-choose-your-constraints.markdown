---
layout: post
title: "Choose Your Constraints"
date: 2016-01-04 00:04:10 +0200
comments: true
categories:
- blog
- Programming
twitter:
  description: Constraints are a choice not of yes or no, but of which.
    Sometimes the right answer is not fewer constraints, but more.
---

A while back I published a few Tweets about constraints.  They seemed to strike
a chord with others, and I want to develop the point a bit more.

So let's start with this: What are some constraints you feel in your day-to-day
coding?  Which factors are limiting your ability to produce new, shippable
features?  Consider the following list:

<div id="constraints-checklist">
  <input type="checkbox" id="time" name="time" value="Time"><label for="time">Time/Deadline</label><br/>
  <input type="checkbox" id="money" name="money" value="Money"><label for="money">Money</label><br/>
  <input type="checkbox" id="legacy" name="legacy" value="Legacy Code"><label for="legacy">Legacy Code/Projects</label><br/>
  <input type="checkbox" id="performance-requirements" name="performance-requirements" value="Performance Requirements"><label for="performance-requirements">Performance Requirements</label><br/>
  <input type="checkbox" id="legal" name="legal" value="Legal Regulations"><label for="legal">Legal Regulations</label><br/>
  <input type="checkbox" id="clients" name="clients" value="Client Restrictions"><label for="clients">Client Restrictions</label><br/>
  <input type="checkbox" id="hardware" name="hardware" value="Hardware"><label for="hardware">Hardware</label><br/>
  <input type="checkbox" id="competing-projects" name="competing-projects" value="Competing Projects"><label for="competing-projects">Competing Projects</label><br/>
  <input type="checkbox" id="skills" name="skills" value="Skills"><label for="skills">Team Members' Skills</label>
</div>
<br/>

Take a moment and check off the 3 biggest pain points in your current job.

<!-- more -->

You've selected:

<ul id="constraints-results"></ul>

Hold that thought; let's talk for a moment about the most significant force
behind your (and all developers') frustrations, and how it underlies the factors
you've chosen.

### The Triple Constraint

The Triple Constraint, also known as the Project Management Triangle, is
well-known as a classic line developers tell overzealous managers:

> We can build it with every feature, on time, and on budget.  Pick two.

The Triple Constraint sets up a fundamental tension between three factors:

1. Time (how quickly the project is done)
2. Cost (how much it costs to complete the project)
3. Scope (how many features are built, and how well)

Any time you make greater demands in one aspect, at least one of the others will
have to give.  If you reduce the time for the project, you'll need to pay more
or (more realistically) cut scope.  Want to save money?  Cut scope, or hire
developers who will do it more slowly.  To increase the scope, pay more, or
better, developers, to work on it for the same amount of time, or increase the
length of time allotted for the project.

Let's see how the Triple Constraint applies to the problems you've selected:

<p id="constraints-interpretation"></p>

So it looks like <span id="biggest-problems"></span>.  With that in mind, let's
think about a more active approach to controlling and choosing our constraints.

### Constraints: A Choice of Which, Not Whether

The point of the Triple Constraint is to emphasize that constraints will exist
on every project, and we are responsible for managing them realistically.  There
is great temptation to assume that with extra effort we can cheat the system and
push for a better outcome on all 3 constraints.  That's just not possible.

However, by acknowledging and embracing our constraints, we can maximize the
outcome.  We cannot build every feature, on time, and on budget.  But we can
build the right set of features, given the right amount of time and an
appropriate budget.

Let's think about this in the context of the issues you selected.

<div id="constraints-suggestions"></div>

The main point here is that each of Cost, Scope, and Time constraints will get
the best of you, unless you actively acknowledge the conflict, and make sure
your efforts reflect the true business priorities.  Attempting to maximize all
three is impossible and will usually lead to significant shortcomings in all
three areas.

### Adding More Constraints

This is the Tweetstorm (yes, my own) that originally got me thinking:

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">Your current constraints ultimately train you to operate effectively within precisely those constraints. Choose your constraints wisely.</p>&mdash; Ariel Caplan (@amcaplan) <a href="https://twitter.com/amcaplan/status/670030185106907136">November 27, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" data-conversation="none" lang="en"><p lang="en" dir="ltr">Take on too much work for the time allotted, you will learn to overwork and underdeliver, and you&#39;ll stop noticing that it&#39;s happening.</p>&mdash; Ariel Caplan (@amcaplan) <a href="https://twitter.com/amcaplan/status/670030975620005890">November 27, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" data-conversation="none" lang="en"><p lang="en" dir="ltr">Always make time for testing, pairing, knowledge sharing, and learning. Eventually they will happen automatically without special effort.</p>&mdash; Ariel Caplan (@amcaplan) <a href="https://twitter.com/amcaplan/status/670031382144528385">November 27, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet" data-conversation="none" lang="en"><p lang="en" dir="ltr">Took me &gt;1yr to get used to TDD. But now it comes free, without thinking about it, and the benefits are tangible.</p>&mdash; Ariel Caplan (@amcaplan) <a href="https://twitter.com/amcaplan/status/670031749641076737">November 27, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Now that I've thought things through more clearly, let's summarize using the
terms above.  You already work within constraints of Cost, Scope, and Time.  If
you ignore the competitive nature of those constraints, you will overwork
yourself, fail to deliver the entire Scope, miss the deadline, or—even worse—all
three.  This will become the <em>de facto</em> mode of operation, much to the
consternation of yourself, your colleagues, and your managers.  Worse, you will
take on the Cost of long-term technical debt because it allows you to expand
Scope and minimize Time in the short term.

The only solution is to embrace the fact that you just can't do everything, and
take on constraints that will safeguard you from the poor decision-making that
brings on long-term troubles.

The four constraints I recommend budgeting for, as mentioned above, are:

1. **Testing:** Insist on meaningful test coverage.  There are advantages to
writing your tests first, but at least make sure you end up with solidly tested
code.
    * You will know your code works, and it will be much easier to change or
    extend later without breaking everything.
    * It's hard to know you've accomplished the appropriate Scope without a
    reproducible test, and not testing increases the Cost of adding features
    later.

1. **Pairing:** Don't let a sprint go by without finding an opportunity to pair
on something, anything.
    * Pairing is not always the best use of resources (you might say it's double
    the Cost), but often the synergy of two coders talking things out nets an
    overall gain in productivity.
    * Pairing also provides a host of benefits for the long term, in terms of
    team relationships and knowledge sharing.  Which brings us to the next
    point...

1. **Knowledge Sharing:** Make time in your workflow to share knowledge, both
formally and informally.
    * Meet weekly with your team and have someone present their recent work.
    Eventually everyone will take a (temporary or permanent) vacation, and
    someone else will need to fill their role.  Pay down the Cost of a weekly
    hour-long meeting, so your team isn't frozen when one person takes a
    much-needed break.
    * Look for opportunities to pair junior and senior developers together.  Or
    if someone is unfamiliar with part of the codebase, assign them a ticket
    that requires them to learn it, and designate a knowledgeable pair. The
    stronger each member of your team becomes, the more quickly you can build
    new features in a stable fashion.

1. **Learning:** I expect this to be controversial, but here goes.  Make time in
your workday for something code-related that has nothing to do with your work.
Try out a new language or framework.  Write a script to automate something at
home.  Read an article from one of
[Peter Cooper's newsletters](http://peterc.org/#ap3) or watch a talk on
[Confreaks](http://confreaks.tv/events).  Follow the Twitter account of a
developer you respect and read what they post.  Broaden your horizons in code,
and you'll find that some of your most brilliant ideas at work will come from
your explorations.  You can't be inspired without inspiration.

The crazy thing about these practices is that if you constrain yourself for long
enough, they become second nature, and you don't notice the time they take up.
Eventually, your budget will automatically include these activities.  Yet you
will be able to crank out features at a quicker, more stable pace, precisely
*because* you are taking the time to invest in yourself and your code.

You will also notice a greater sense of team cohesiveness.  These practices
encourage the team to work together, to learn together, and to help each other
grow in capacity to produce excellent software.  These practices bring out the
synergetic relationships that make team-built software qualitatively better than
software produced by individuals.

Sometimes, it will be difficult to get buy-in from the more business-minded
stakeholders in your company.  For this reason, make sure to couch the
conversation in terms of risk avoidance and long-term business objectives, which
honestly should be your goal, too.

### A Call to Action

Let's end with a challenge, shall we?  Commit to one—just one—of these four
practices for the next two weeks.  Then let's hear some feedback about how you
did, and what type of impact it had on yourself, your code, and your team.

* [Commit to Testing](https://twitter.com/intent/tweet?original_referer=http%3A%2F%2Famcaplan.ninja%2Fblog%2FProgramming%2F2016%2F01%2F04%2Fchoose-your-constraints%2F&ref_src=twsrc%5Etfw&text=I%20will%20insist%20on%20meaningful%20test%20coverage%20for%20the%20next%202%20weeks.%20Make%20a%20pledge%3A&tw_p=tweetbutton&url=http%3A%2F%2Famcaplan.ninja%2Fblog%2FProgramming%2F2016%2F01%2F04%2Fchoose-your-constraints%2F&via=amcaplan)
* [Commit to Pairing](https://twitter.com/intent/tweet?original_referer=http%3A%2F%2Famcaplan.ninja%2Fblog%2FProgramming%2F2016%2F01%2F04%2Fchoose-your-constraints%2F&ref_src=twsrc%5Etfw&text=I%20will%20make%20time%20for%20pairing%20during%20the%20next%202%20weeks.%20Make%20a%20pledge%3A&tw_p=tweetbutton&url=http%3A%2F%2Famcaplan.ninja%2Fblog%2FProgramming%2F2016%2F01%2F04%2Fchoose-your-constraints%2F&via=amcaplan)
* [Commit to Knowledge Sharing](https://twitter.com/intent/tweet?original_referer=http%3A%2F%2Famcaplan.ninja%2Fblog%2FProgramming%2F2016%2F01%2F04%2Fchoose-your-constraints%2F&ref_src=twsrc%5Etfw&text=I%20will%20organize%20a%20regular%20knowledge%20sharing%20session%20starting%20in%20the%20next%202%20weeks.%20Make%20a%20pledge%3A&tw_p=tweetbutton&url=http%3A%2F%2Famcaplan.ninja%2Fblog%2FProgramming%2F2016%2F01%2F04%2Fchoose-your-constraints%2F&via=amcaplan)
* [Commit to Learning](https://twitter.com/intent/tweet?original_referer=http%3A%2F%2Famcaplan.ninja%2Fblog%2FProgramming%2F2016%2F01%2F04%2Fchoose-your-constraints%2F&ref_src=twsrc%5Etfw&text=I%20will%20dedicate%20time%20to%20non-work-related%20programming%20learning%20during%20the%20next%202%20weeks.%20Make%20a%20pledge%3A&tw_p=tweetbutton&url=http%3A%2F%2Famcaplan.ninja%2Fblog%2FProgramming%2F2016%2F01%2F04%2Fchoose-your-constraints%2F&via=amcaplan)

<script type="text/javascript">
  (function(){
    var inputs = document.getElementById('constraints-checklist').getElementsByTagName('input');

    var selectedInputs = function() {
      checkedInputs = [];

      for (var i = 0; i < inputs.length; i++) {
        input = inputs[i]
        if (input.checked) { checkedInputs.push(input); }
      }

      return checkedInputs;
    };

    var noSelectionMade = '&lt;NO SELECTION MADE&gt;';

    var inputText = function(input){ return input.labels[0].textContent; }
    var liIfy = function(text) { return "<li>" + text + "</li>"; };

    var setResultsHTML = function(selected) {
      if (selected.length === 0) { html = noSelectionMade; }
      else {
        html = selected.map(inputText).map(liIfy).join('');
      }
      document.getElementById('constraints-results').innerHTML = html;
    };

    var interpretations = {
      "time": "Time is <strong>Time</strong>, easy enough.",
      "money": "Money is one element of <strong>Cost</strong>.",
      "legacy": "When you pay down technical debt on legacy code and projects, you encounter the <strong>Cost</strong> of a past project, except that you incur those costs now.",
      "performance-requirements": "Performance requirements are an aspect of <strong>Scope</strong>.",
      "legal": "Legal requirements are an aspect of <strong>Scope</strong>.",
      "clients": "Client requirements are an aspect of <strong>Scope</strong>.",
      "hardware": "Insufficient hardware resources reflect an upper bound on <strong>Cost</strong>.",
      "competing-projects": "Assigning developers to too many simultaneous projects reflects unwillingness to accept the true <strong>Cost</strong> of each project.",
      "skills": "When team members lack the skills to complete the task, the learning involved becomes part of the <strong>Cost</strong> of the project."
    };
    var interpretation = function(input) { return interpretations[input.name]; }

    var setInterpretationHTML = function(selected) {
      if (selected.length === 0) { html = ''; }
      else {
        html = '<ul>' +
          selected.map(interpretation).map(liIfy).join('') +
          '</ul>';
      }
      document.getElementById('constraints-interpretation').innerHTML = html;
    }

    var problems = {
      "time": "Time",
      "money": "Cost",
      "legacy": "Cost",
      "performance-requirements": "Scope",
      "legal": "Scope",
      "clients": "Scope",
      "hardware": "Cost",
      "competing-projects": "Cost",
      "skills": "Cost"
    };
    var problemList = function(selected) {
      var list = [];
      selected.forEach(function(input) {
        var problem = problems[input.name];
        if (list.indexOf(problem) === -1) { list.push(problem); }
      });
      return list.sort();
    };
    var outputProblemList = function(list) {
      switch(list.length) {
        case 0:
          return "your biggest problems are &lt;UNKNOWN - FILL IN PLEASE&gt;";
        case 1:
          return "your biggest problem is " + list[0];
        case 2:
          return "your biggest problems are " + list[0] + " and " + list[1];
        case 3:
          return "you are struggling on all 3 fronts: Cost, Scope, and Time"
      }
    };
    var updateProblemList = function(inputs) {
      document.getElementById('biggest-problems').innerHTML =
        outputProblemList(problemList(inputs));
    };

    var suggestions = {
      "time": "<strong>Time/Deadlines:</strong> Sometimes, your product's greatest feature is time - for example, it must capture the market before competitors arrive.  In other cases, time is less crucial than other factors.  So it's important to evaluate the significance of the deadline in your situation.  Often the right answer is multifaceted - for example, extending the deadline by a month along with cutting scope in certain ways.",
      "money": "<strong>Money:</strong> This question will be fundamentally different depending on the scenario.  In a small startup launching its first product, you may not have the leeway to increase Cost.  This is why startups tend to build small, streamlined products that are sold on their simplicity; they cut Scope, because money is limited, and a long time-to-market will kill the company financially.  In a large company, though, the right answer may be to build the product with full scope, but extend the Time or accept increased Cost.",
      "legacy": "<strong>Legacy Infrastructure:</strong> If you struggle with legacy code or even full applications, congratulations!  Your product has been around for a while, it's hopefully well-established, but it comes with the messiness of decisions which—as you can see using your 20/20 hindsight—have turned out for the worse.  The answer is usually to minimize Cost by paying down technical debt when possible, but accept that sometimes the value of Time will triumph.  Usually businesspeople err on the side of not paying down technical debt; your job as developer is to counter that trend, diplomatically of course.",
      "performance-requirements": "<strong>Performance:</strong> Whether you're building for desktop, mobile, tablet, or the web, performance is going to be a make-or-break for your product.  And performance has a tangible Cost in terms of developer attention and effort.  The company needs to accept that performance will require massive attention, especially over time as more and more features are added.  The right answer is usually to cut feature Scope when performance becomes a problem, and not before.  It's also important to understand how valuable performance gains are in any situation, and make sure a proportional amount of developer resources are dedicated to performance improvements.  Too little attention and performance problems will be the death of your product; too much attention and your product's feature set will go nowhere.",
      "legal": "<strong>Legal Requirements:</strong> These are generally non-negotiable.  Once we accept that, it's important to view fulfillment of legal requirements as a Scope achievement, and cut other Scope considerations as necessary.  Better 2 new features than 3 features plus a lawsuit.",
      "clients": "<strong>Client Requirements:</strong> Keep in mind, your client is the one paying your bills.  However, clients often use that position to demand more features than are healthy for your product.  It's important to be honest with clients about the limitations of your team, and explain that you want your product to grow stably in the long term.  Pushing lots of features out the door quickly will limit your product's ability to grow, and that will hurt your clients as well later on.  Negotiate your clients down to a reasonable feature set given the Time and Cost constraints of your project—and make sure to deliver.",
      "hardware": "<strong>Hardware Limitations:</strong> These cases generally fall into two categories.  One is a small company with severe financial constraints.  In that case, the answer is probably to wait on certain features until the company begins to gather more revenue.  Small companies have a tendency to try to scale too early; wait until the need arises.  (In other words, limit the Scope of your operations until the market demands more.)  Larger companies have the opposite problem; they know the scale is necessary, but may not have financial resources available now, or the process of getting appropriate hardware may take time.  The right answer is usually to shelve the project for now; there are probably many other projects deserving of attention that would provide value immediately.",
      "competing-projects": "<strong>Competing Projects</strong>: Companies are often unaware of the Cost of context switching.  To minimize Cost, a developer should work on only one project at a time.  If multiple projects need attention, every effort should be made to limit Scope or extend Time in a way that allows each developer to give their undivided attention to one project, perhaps switching back and forth at intervals of one to two weeks.  Greater flexibility will pay off in increased productivity.",
      "skills": "<strong>Team Members' Skills:</strong> Developers, contrary to popular belief, are not code-generation machines.  They are human beings who know some things and do not know other things.  Part of the Cost of a project is the need for developers to educate themselves about the necessary tools and the problem space.  This must be considered as a factor that will challenge Time and Scope."
    };

    var suggestionList = function(inputs) {
      if (inputs.length === 0) { return [noSelectionMade]; }
      return inputs.map(function(input) {
        return '<li>' + suggestions[input.name] + '</li>';
      });
    };

    var updateSuggestionList = function(inputs) {
      document.getElementById('constraints-suggestions').innerHTML =
        '<ul>' + suggestionList(inputs).join('') + '</ul>';
    };

    var uncheckIfFourth = function() {
      if (selectedInputs().length > 3) { this.checked = false; }
    };

    var updateFields = function(){
      selected = selectedInputs();
      setResultsHTML(selected);
      setInterpretationHTML(selected);
      updateProblemList(selected);
      updateSuggestionList(selected);
    }

    for (var i = 0; i < inputs.length; i++) {
      input = inputs[i];
      input.addEventListener('change', uncheckIfFourth, false);
      input.addEventListener('change', updateFields, false);
    }

    document.addEventListener('DOMContentLoaded',function(){
      updateFields();
    });
  })()
</script>

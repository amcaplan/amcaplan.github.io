---
author: amcaplan
comments: true
date: 2014-05-01 23:40:43+00:00
layout: post
slug: coffeescript-101
title: CoffeeScript 101
wordpress_id: 125
categories:
- blog
tags:
- JavaScript
- Programming
- CoffeeScript
---

"CoffeeScript, c'mon and/ take a sip, they call it/ CoffeeScript, Coff-"

\- oh, sorry, didn't see you there! I was just humming the jingle from [CodeSchool's CoffeeScript course](https://www.codeschool.com/courses/coffeescript). Been working on it for a few days. I've never been a huge fan of the brown caffeinated stuff, but CoffeeScript? I'm addicted.

CoffeeScript is described by its creator, Jeremy Ashkenas, as "a little language that compiles into JavaScript." Here's how I would describe it: "JavaScript is written to give you a brain hemorrhage. CoffeeScript is more like a mild migraine."

<!-- more -->

Essentially, CoffeeScript is a language that compiles 1-to-1 to JavaScript, but is more clear and less error-prone. Forget the dreaded `var` keyword; it has no place in the wonderful world of CoffeeScript, because it's added automatically.  I like semicolons in English sentences; however, in the world of JavaScript, it's difficult to remember every semicolon.  Thankfully, Automatic Semicolon Insertion will usually take care of it, but it can lead to unexpected results.  With CoffeeScript, no more semicolons!  And those pesky braces (`{}`) appearing all over the place?  Gone!

Now, some would say, "Hey, what are you doing with my beautiful JavaScript?  It was so precise, so explicit!"  I would tell them to go try Ruby and understand that `extraBoilerplate !== greaterPrecision` (I wrote that in JS so they would understand).  Or, as you would write it in CoffeeScript, `extraBoilerplate isnt greaterPrecision`.  (Yes, the ' was left out of isnt on purpose - that's how it's spelled in CoffeeScript.)

Just to demonstrate how awesome CoffeeScript is, I'm going to write the rest of this post in CoffeeScript to show that it's really much simpler.


``` coffeescript coffeescript_demo.js.coffee
class Reader
  inAttendance: yes
  payAttention: ->
    alert 'Wake up and pay attention!'
you = new Reader
you.payAttention()

class DemoOfCoolThingsAboutCoffeeScript

  functions: ->
    console.log 'As you can see, functions are defined without ' +
    '"function()" or "{}"s. Just a simple "->" - but make sure' +
    ' to keep track of your indentations!'

  classes: ->
    console.log 'It has classes. No more awkward JS inheritance!'

  punctuation: ->
    console.log "Have you noticed that I've been leaving out commas" +
    " and semicolons and braces? Indentation is way more natural..." +
    "\nAlso, see how parentheses are unnecessary on the " +
    "outermost function call?"

  splats: (params...)->
    console.log "I can splat arguments, in both function definitions " +
    "and function calls. In this case, I used #{params.length} params." +
    " Oh, did we mention string interpolation?"

  conditionals: ->
    switchVar = on
    if switchVar
      @showHowThisWorks(yes)
    else
      console.log 'The switch is off!'

  showHowThisWorks: (comingFromSwitch...)->
    if comingFromSwitch[0]
      console.log 'This function was called from switch using "@", ' +
      'which is a handy substitute for "this"'

  makingObjects: ->
    aboutMe =
      name: "Ariel Caplan"
      twitter: "@amcaplan"
      field: "software development"
      enjoysLongWalksOnTheBeach: yes
    if aboutMe.enjoysLongWalksOnTheBeach
      console.log "#{aboutMe.name}, what is this, a personals ad?"
    else
      console.log "#{aboutMe.name}, do you have no heart?"

  implicitReturns: ->
    returningFunction = ->
      "Hey, I never explicitly returned anything! How did you get this string?"
    console.log returningFunction()

  runEverything: ->
    @[propName]() for propName of this when propName isnt 'runEverything'

d = new DemoOfCoolThingsAboutCoffeeScript
d.runEverything()
```



Still JS-y syntax (it's just impossible to escape), but isn't it at least a bit clearer?

Hopefully this has been a pleasant little introduction to CoffeeScript.  You can run the code [on CoffeeScript's website here](http://goo.gl/ixtsO7).  (Click "run" on the top-right, and watch what happens in your console!)  And while you're there, read up on the language and all its features, try writing some of your own in the "Try CoffeeScript" modal, and maybe even take [the CodeSchool course](https://www.codeschool.com/courses/coffeescript).  You won't regret it!

P.S. Bonus extra life!!! Check out some real-life jQuery/CoffeeScript action in the code for the Flatiron Showcase website.  I have some simple DOM manipulation stuff that I just converted to CoffeeScript yesterday.  [Check it out on Github!](https://github.com/amcaplan/flatiron_showcase/blob/d952882068f13231cd3272a71f992ffcf3e25076/app/assets/javascripts/images.js.coffee)

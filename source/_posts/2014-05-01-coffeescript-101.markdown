---
author: amcaplan
comments: true
date: 2014-05-01 23:40:43+00:00
layout: post
slug: coffeescript-101
title: CoffeeScript 101
wordpress_id: 125
categories:
- JavaScript
- Programming
tags:
- CoffeeScript
---

"CoffeeScript, c'mon and/ take a sip, they call it/ CoffeeScript, Coff-"

- oh, sorry, didn't see you there! I was just humming the jingle from [CodeSchool's CoffeeScript course](https://www.codeschool.com/courses/coffeescript). Been working on it for a few days. I've never been a huge fan of the brown caffeinated stuff, but CoffeeScript? I'm addicted.

CoffeeScript is described by its creator, Jeremy Ashkenas, as "a little language that compiles into JavaScript." Here's how I would describe it: "JavaScript is written to give you a brain hemorrhage. CoffeeScript is more like a mild migraine."

Essentially, CoffeeScript is a language that compiles 1-to-1 to JavaScript, but is more clear and less error-prone. Forget the dreaded `var` keyword; it has no place in the wonderful world of CoffeeScript, because it's added automatically.  I like semicolons in English sentences; however, in the world of JavaScript, it's difficult to remember every semicolon.  Thankfully, Automatic Semicolon Insertion will usually take care of it, but it can lead to unexpected results.  With CoffeeScript, no more semicolons!  And those pesky braces (`{}`) appearing all over the place?  Gone!

Now, some would say, "Hey, what are you doing with my beautiful JavaScript?  It was so precise, so explicit!"  I would tell them to go try Ruby and understand that `extraBoilerplate !== greaterPrecision` (I wrote that in JS so they would understand).  Or, as you would write it in CoffeeScript, `extraBoilerplate isnt greaterPrecision`.  (Yes, the ' was left out of isnt on purpose - that's how it's spelled in CoffeeScript.)

Just to demonstrate how awesome CoffeeScript is, I'm going to write the rest of this post in CoffeeScript to show that it's really much simpler.


    
    <code>
    class Reader
      inAttendance: yes
      payAttention: ->
        alert 'Wake up and pay attention!'</code>
    <code>
    you = new Reader
    you.payAttention()</code>
    
    <code>
    class DemoOfCoolThingsAboutCoffeeScript</code>
    
    <code>  functions: ->
        console.log 'As you can see, functions are defined without ' +
        '"function()" or "{}"s. Just a simple "->" - but make sure' +
        ' to keep track of your indentations!'</code>
    
    <code>  classes: ->
        console.log 'It has classes. No more awkward JS inheritance!'</code>
    
    <code>  punctuation: ->
        console.log "Have you noticed that I've been leaving out commas" +
        " and semicolons and braces? Indentation is way more natural..." +
        "\nAlso, see how parentheses are unnecessary on the " +
        "outermost function call?"</code>
    
    <code>  splats: (params...)->
        console.log "I can splat arguments, in both function definitions " +
        "and function calls. In this case, I used #{params.length} params." +
        " Oh, did we mention string interpolation?"</code>
    
    <code>  conditionals: ->
        switchVar = on
        if switchVar
          @showHowThisWorks(yes)
        else
          console.log 'The switch is off!'</code>
    
    <code>  showHowThisWorks: (comingFromSwitch...)->
        if comingFromSwitch[0]
          console.log 'This function was called from switch using "@", ' +
          'which is a handy substitute for "this"'</code>
    
    <code>  makingObjects: ->
        aboutMe =
          name: "Ariel Caplan"
          twitter: "@amcaplan"
          field: "software development"
          enjoysLongWalksOnTheBeach: yes
        if aboutMe.enjoysLongWalksOnTheBeach
          console.log "#{aboutMe.name}, what is this, a personals ad?"
        else
          console.log "#{aboutMe.name}, do you have no heart?"</code>
    
    <code>  implicitReturns: ->
        returningFunction = ->
          "Hey, I never explicitly returned anything! How did you get this string?"
        console.log returningFunction()</code>
    
    <code>  runEverything: ->
        @[propName]() for propName of this when propName isnt 'runEverything'</code>
    
    <code>d = new DemoOfCoolThingsAboutCoffeeScript
    d.runEverything()</code>
    



Still JS-y syntax (it's just impossible to escape), but isn't it at least a bit clearer?

Hopefully this has been a pleasant little introduction to CoffeeScript.  You can run the code [on CoffeeScript's website here](http://coffeescript.org/#try:class%20Reader%0A%20%20inAttendance%3A%20yes%0A%20%20payAttention%3A%20-%3E%0A%20%20%20%20alert%20'Wake%20up%20and%20pay%20attention!'%0A%0Ayou%20%3D%20new%20Reader%0Ayou.payAttention()%0A%0A%0A%0Aclass%20DemoOfCoolThingsAboutCoffeeScript%0A%0A%20%20functions%3A%20-%3E%0A%20%20%20%20console.log%20'As%20you%20can%20see%2C%20functions%20are%20defined%20without%20%22function()%22%20or%20%22%7B%7D%22s.%20%20Just%20a%20simple%20%22-%3E%22%20-%20but%20make%20sure%20to%20keep%20track%20of%20your%20indentations!'%0A%0A%20%20classes%3A%20-%3E%0A%20%20%20%20console.log%20'It%20has%20classes.%20No%20more%20awkward%20JS%20inheritance!'%0A%0A%20%20punctuation%3A%20-%3E%0A%20%20%20%20console.log%20%22Have%20you%20noticed%20that%20I've%20been%20leaving%20out%20commas%20and%20semicolons%20and%20braces%3F%20Indentation%20is%20way%20more%20natural...%5CnAlso%2C%20see%20how%20parentheses%20are%20unnecessary%20on%20the%20outermost%20function%20call%3F%22%0A%0A%20%20splats%3A%20(params...)-%3E%0A%20%20%20%20console.log%20%22I%20can%20splat%20arguments%2C%20in%20both%20function%20definitions%20and%20function%20calls.%20%20In%20this%20case%2C%20I%20used%20%23%7Bparams.length%7D%20params.%20%20Oh%2C%20did%20we%20mention%20string%20interpolation%3F%22%0A%0A%20%20conditionals%3A%20-%3E%0A%20%20%20%20switchVar%20%3D%20on%0A%20%20%20%20if%20switchVar%0A%20%20%20%20%20%20%40showHowThisWorks(yes)%0A%20%20%20%20else%0A%20%20%20%20%20%20console.log%20'The%20switch%20is%20off!'%0A%0A%20%20showHowThisWorks%3A%20(comingFromSwitch...)-%3E%0A%20%20%20%20if%20comingFromSwitch%5B0%5D%0A%20%20%20%20%20%20console.log%20'This%20function%20was%20called%20from%20switch%20using%20%22%40%22%2C%20which%20is%20a%20handy%20substitute%20for%20%22this%22'%0A%0A%20%20makingObjects%3A%20-%3E%0A%20%20%20%20aboutMe%20%3D%0A%20%20%20%20%20%20name%3A%20%22Ariel%20Caplan%22%0A%20%20%20%20%20%20twitter%3A%20%22%40amcaplan%22%0A%20%20%20%20%20%20field%3A%20%22software%20development%22%0A%20%20%20%20%20%20enjoysLongWalksOnTheBeach%3A%20yes%0A%20%20%20%20if%20aboutMe.enjoysLongWalksOnTheBeach%0A%20%20%20%20%20%20console.log%20%22%23%7BaboutMe.name%7D%2C%20what%20is%20this%2C%20a%20personals%20ad%3F%22%0A%20%20%20%20else%0A%20%20%20%20%20%20console.log%20%22%23%7BaboutMe.name%7D%2C%20do%20you%20have%20no%20heart%3F%22%0A%0A%20%20implicitReturns%3A%20-%3E%0A%20%20%20%20returningFunction%20%3D%20-%3E%0A%20%20%20%20%20%20%22Hey%2C%20I%20never%20explicitly%20returned%20anything!%20%20How%20did%20you%20get%20this%20string%3F%22%0A%20%20%20%20console.log%20returningFunction()%0A%0A%20%20runEverything%3A%20-%3E%0A%20%20%20%20%40%5BpropName%5D()%20for%20propName%20of%20this%20when%20propName%20isnt%20'runEverything'%0A%0Ad%20%3D%20new%20DemoOfCoolThingsAboutCoffeeScript%0Ad.runEverything()).  (Click "run" on the top-right, and watch what happens in your console!)  And while you're there, read up on the language and all its features, try writing some of your own in the "Try CoffeeScript" modal, and maybe even take [the CodeSchool course](https://www.codeschool.com/courses/coffeescript).  You won't regret it!

P.S. Bonus extra life!!! Check out some real-life jQuery/CoffeeScript action in the code for the Flatiron Showcase website.  I have some simple DOM manipulation stuff that I just converted to CoffeeScript yesterday.  [Check it out on Github!](https://github.com/amcaplan/flatiron_showcase/blob/d952882068f13231cd3272a71f992ffcf3e25076/app/assets/javascripts/images.js.coffee)

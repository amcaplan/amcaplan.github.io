---
author: amcaplan
comments: true
layout: post
title: "Closures and Callbacks: Running Arbitrary Task Sets Synchronously in JavaScript"
date: 2014-08-24 16:25:29 -0400
comments: true
categories:
- blog
- Programming
- JavaScript
tags:
- JavaScript
- closures
- callbacks
---

On the Vitals Choice team, we have divided our product into a number of apps.
Each of those apps has one running instance per environment , and we have
several environments.  So as you might imagine, making sure updated code
gets propagated through all those places at the right time can be quite
the task.  Luckily, we have a Hubot instance which does most of the heavy
lifting, but even issuing all the Hubot commands for every single app makes you
wonder: shouldn't there be a way to automate this better?

Well, it turns out that an attempt had been made in the past, but we ran into
a problem: JavaScript's asynchronicity.  The server hosting Hubot was suddenly
told to update all the apps for a particular environment, and the simultaneous
processes overwhelmed the CPU and memory.

Considering the problem, I realized that callbacks were the way to go.  Hubot
comes with an evented system, which we could utilize to force Hubot to only
launch one app at a time.  Here's what I came up with, and what I learned along
the way.

<!-- more -->

*[Note: code examples have been simplified for readability, and proprietary
secrets have been removed.]*

###Step 1: Implement callbacks for the deploy script

Initially, groundwork needed to be laid for post-deploy callbacks.  This was
relatively simple to implement (all examples in CoffeeScript):
``` coffeescript
deploy = (app, env, callback) ->
  # code to deploy the app, including spawning a Shell script, abstracted
  # in JavaScript by an object held in the variable 'script'
  
  script.on 'close', ->
    callback()
```

###Step 2: Create a function for each app

After quickly setting up a `robot.respond` function (which is how Hubot
responds to a particular chat command), calling a `deployAll` function, I
turned to the hard problem of setting up a series of functions to deploy all
apps, one after the other.  I had a variable accessible as
`robot.brain.PROJECTS`, which was a collection of all the app names, so I
thought to iterate through all the apps, each time capturing the previous
function as a callback of the new function.  This would effectively create
a stack of functions that would be executed one by one, exactly as I described.

``` coffeescript
deployAll = (env, msg)->
  callback = ->
    msg.send "Finished deploying all the apps!"

  for app in robot.brain.PROJECTS
    # Reassign `callback` to a new function...
    callback = ->
      # which passes the current `callback` as a callback to `deploy`
      deploy(app, env, callback)

  callback() # Start the chain!
```

It all seemed to make sense, until I actually tested it.  For some reason,
it just tried to deploy the last app again and again.  What gives?

###Step 2.5: Grokking Scope and Lazy Function Evaluation

It turns out that in the loop, when I redefined `callback`, it associated the
`callback` variable with a new function, but within the function, it didn't
yet do anything with the line `deploy(app, env, callback)`.  This is because
functions exist within a particular closure; they will be evaluated as though
they were run in the place where they were defined, with access to all local
variables, but those variables are accessed when the function is actually run,
NOT when the function is defined.

Here's a simpler example:

``` coffeescript
i = 0
logger = ->
  i++
  console.log(i)
logger() # => 1
logger() # => 2
console.log(i) => 2
```

We can see that `i` is defined in the outer scope, modified in the inner scope,
and that change persists in the outer scope.

Let's now look at an example closer to our situation:

``` coffeescript
i = 0
logger = ->
  console.log(i)
i = 7
logger() # => 7
```

As we can see, the `i` inside the function is not fixed, but rather depends on
what happens in its closure at any point before the function is actually
called.

Here's one last example, with a nested function like we had:

``` coffeescript
callbackRunner = (callback) ->
  callback()
onePrinter = ->
  console.log(1)
callbackRunner(onePrinter) # => 1

cbRoP = ->
  callbackRunner(onePrinter)
cbRoP() # => 1

onePrinter = ->
  console.log("one")
cbRoP() # => "one"
```

By redefining `onePrinter` in the outer scope, we changed what `cbRoP` does.
This is because inside `cbRoP`, where `onePrinter` is referenced, that variable
is evaluated only when `cbRoP` is actually called.  The first time, `onePrinter`
prints out 1, but the second time, it prints out "one".  Even within `cbRoP`,
`onePrinter` has been redefined.

###Step 3: Create a Custom Scope

The solution to our problem was to create a scope where the callback wouldn't
change.  Here's the code:

``` coffeescript
deployAll = (env, msg)->
  callback = ->
    msg.send "Finished deploying all the apps!"

  deployFunctionFactory = (app, callback) ->
    ->
      deploy(app, env, callback)

  for app in robot.brain.PROJECTS
    callback = deployFunctionFactory(app, callback)
  
  callback()
```

This is a bit of a mind-bender, so let's explain piece by piece.

- `deployFunctionFactory` takes in a reference to an app and a function to
use as a callback.  It returns a function which, when called, will deploy
the app passed in, and use the callback that is passed in.  Since `callback`
is one of `deployFunctionFactory`'s arguments, it has been captured in the
scope of the function, and nothing outside can change it in the future.

- The `for` loop reassigns `callback` each time to a new function which is
produced on the spot by `deployFunctionFactory`.  The right side of the equals
sign is evaluated immediately, so `callback` is passed into
`deployFunctionFactory`, a new function is returned, and that new function is
assigned to `callback`.

- The cycle repeats for each app, ultimately generating what is effectively
a stack of functions to be called, one after the other.

- When the stack of functions is resolved on the last line, it starts by
running the anonymous function returned by `deployFunctionFactory` for the last
app in `robot.brain.PROJECTS`, since that's the last function that has been
added to the virtual stack.  That function calls `deploy` with the second-to-last
function (which deploys the second-to-last app) as a callback.  When the first
app deployed is done deploying, this callback is run, deploying the next app
in line.

The logic is pretty complex, so here's a visual representation of what all this
code is accomplishing.  We will consider a case of 3 apps to keep it simple.
First, we build the function inside out:

``` coffeescript
1.  callback = ->
      msg.send "Finished deploying all the apps!"

2.  callback = ->
      deploy "app1", env, ->
        msg.send "Finished deploying all the apps!"

3.  callback = ->
      deploy "app2", env, ->
        deploy "app1", env, ->
          msg.send "Finished deploying all the apps!"

4.  callback = ->
      deploy "app3", env, ->
        deploy "app2", env, ->
          deploy "app1", env, ->
            msg.send "Finished deploying all the apps!"
```

Now, when we call `callback`, the functions will be run outside in.  First,
app3 will be deployed.  When that's done, our `deploy` function knows to call
the callback, i.e. the next function, deploying app2.  When app2 finishes being
deployed, app1 will be deployed.  At the end, a message will be sent letting
you know all the apps have been deployed.

###Concluding Thoughts

Using closures and callbacks properly can be a mentally exhausting endeavor.
However, when these factors are properly considered and utilized, you can
accomplish some pretty powerful stuff.

I personally had to try a few iterations before I came up with a workable
solution in this case, but the results were quite satisfying, and it got the
job done.  In the future, if we add apps to `robot.brain.PROJECTS`, the
`deployAll` function won't have to be changed; it will just add more layers
to the nested function we've built.

Using closures and callbacks, we've managed to build a function that will run
an arbitrary number of tasks synchronously.  Sweet!
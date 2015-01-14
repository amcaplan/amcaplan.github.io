---
author: amcaplan
comments: true
date: 2014-03-05 00:32:48+00:00
layout: post
slug: struct-rubys-quickie-class
title: 'Struct: Ruby''s Quickie Class'
wordpress_id: 31
categories:
- Programming
- Ruby
---

Let's say you have Player and BasketballTeam classes that are defined and used as follows:

``` ruby
class Player
  attr_accessor :name, :number
  
  def initialize(name, number)
    @name = name
    @number = number
  end
end
 
 
class BasketballTeam
  attr_accessor :player1, :player2, :player3, :player4, :player5
  
  def initialize(player1, player2, player3, player4, player5)
    @player1 = player1
    @player2 = player2
    @player3 = player3
    @player4 = player4
    @player5 = player5
  end
  
  def starting_lineup
    str = "Ladies and Gentlemen, here is the starting lineup!\n"
    5.times do |num|
      player = self.send("player#{num + 1}")
      str += "\n##{player.number}, #{player.name}!\n"
    end
    str
  end
end
 
 
team = BasketballTeam.new(Player.new("Magic Johnson", 15), Player.new("Michael Jordan", 9),
  Player.new("Larry Bird", 7),Player.new("Charles Barkley", 14),Player.new("Patrick Ewing", 6))
 
puts team.starting_lineup
```

In this case, since there are always exactly 5 players, I don't want to pull out an array every time and write `team.players[0]`, and instead I've chosen to use 5 similarly named instance variables, so I can do `team.player1`.  This looks nice, but also isn't ideal.  If I want to access player n, this starts to get ugly: `team.send("player#{n}")`.

Well, here's the good news\: as usual, Ruby has a better way for you to do it.

<!-- more -->

Introducing: the Struct class!  Structs fall somewhere between full-fledged Ruby classes and arrays/hashes, and are excellent for generating classes which are mostly variable storage containers with a particular number of items, with a small number of methods.  Here is how we would refactor our code from before:

``` ruby
Player = Struct.new(:name, :number)
 
BasketballTeam = Struct.new(:player1, :player2, :player3, :player4, :player5) do
  def starting_lineup
    "Ladies and Gentlemen, here is the starting lineup!\n" +
      self.collect {|player| "\n##{player.number}, #{player.name}!\n"}.join
  end
end
 
team = BasketballTeam.new(Player.new("Magic Johnson", 15), Player.new("Michael Jordan", 9),
  Player.new("Larry Bird", 7),Player.new("Charles Barkley", 14),Player.new("Patrick Ewing", 6))
 
puts team.starting_lineup
```

Huh?  Where did all the code go?

Struct.new is a really cool method that takes symbols as arguments and returns - no, it's not an object, it's a class!!!  (Well, technically all Ruby classes are objects too, but we're going to deliberately ignore that for now.)  It takes each symbol, makes it an instance variable, gives it setter and getter methods, and adds it to the initialize method in the order specified.  So it's doing a lot of work for you, just for adding the symbol there.  The optional block at the end (see how `BasketballTeam` is created with a block but `Player` isn't?) specifies any methods you want to add to the struct.  If you have a lot of these, Struct probably isn't for you.  But if it's just one or two simple methods, then Struct may still be a good idea.

An examination of Struct's instance methods reveals its similarity to Array and Hash.  Here are my favorites:

<table >
  
    
<td >Method
</td>
<td >Description and Correlatives
</td>
  
  <tbody >
    <tr >
<td >
  `#members`
</td>
<td >like `Hash#keys`, returns an array containing the instance variable names
</td></tr>
    <tr >
<td >`#values`
</td>
<td >like `Hash#values`, returns an array containing the instance variable values
</td></tr>
    <tr >
<td >`#length`, `#size`
</td>
<td >like `Hash#size` or `Array#size`, the number of instance variables
</td></tr>
    <tr >
<td >`#each`
</td>
<td >similar to `Hash#each`, goes through each instance variable's value
</td></tr>
    <tr >
<td >`#[member]`  
(e.g. `team["player1"]` or `team[:player1]`)
</td>
<td >similar to `Hash#[]`, access by instance variable name
</td></tr>
    <tr >
<td >`#[index]`  
(e.g. `team[0])`
</td>
<td >similar to `Array#[]`, access by variable index in `#members`
</td></tr>
  </tbody>
</table>

NOTE: You can also write `team[0] = Player.new("Magic Johnson", 15)`

Of course, you are also able to get `team.player1` because it attr_accessor'ed everything for you.

Because Struct defines an `#each` method and includes Enumerable, you can use any of the Enumerable methods on its properties.  So you can `cycle`, check if `team.any? {|player| player.name == "Michael Jordan"}`, `inject`, or find the `team.max_by(&:number)`, among others.  You can also modify all contained values pretty easily: `team.each{|player| player.number += 1}` (in case you needed to bump up everyone's number for some reason).  And if the IOC is insisting you sort your players by jersey number, just `team.sort_by(&:number)` and you're all set!  Patrick Ewing, with jersey #6, is now `team[0]`, a.k.a. `team.player1`.

One downside of Struct as opposed to Arrays is that you can't push/pop/unshift/shift, because the size is fixed from the beginning.

**TL;DR** A struct is somewhere between a regular object and a hash/array.  It's an awesome data structure when you



  
  * know exactly what it needs to hold

  
  * want to be able to access your data in a variety of useful ways

  
  * need to define just a small number of custom methods (or none at all)

  
  * and just don't want to write much boilerplate code while doing it!



P.S. Check out [this post](http://blog.steveklabnik.com/posts/2012-09-01-random-ruby-tricks--struct-new) from Steve Klabnik about how incorporating structs into your regular class definitions can make your debugging much easier due to Struct's handy `#to_s` method.

P.P.S. Robert Klemme [helpfully notes](http://blog.rubybestpractices.com/posts/rklemme/017-Struct.html) that, unlike hashes, struct["something"] will raise an error if there is no @something variable.  This can be helpful if you want to detect certain types of input problems.

P.P.P.S. Here's the output from the code above (using structs or regular classes), if you're desperately interested:

    Ladies and Gentlemen, here is the starting lineup!

    #15, Magic Johnson!

    #9, Michael Jordan!

    #7, Larry Bird!

    #14, Charles Barkley!

    #6, Patrick Ewing!
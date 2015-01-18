---
author: amcaplan
comments: true
date: 2014-03-19 00:56:00+00:00
layout: post
slug: exploring-security-and-secret-tokens-through-facebook-login
title: Exploring Security and Secret Tokens Through Facebook Login
wordpress_id: 58
categories:
- blog
tags:
- Experiences
- Programming
- Rails
- Security
- Walkthroughs
- Facebook
- OmniAuth
- Secret Token
---

Security is really scary.  How scary?  Well, according to [this very pretty infographic](http://www.erieinsurance.com/identitytheft/), it costs US residents $13.3 billion and 383 million hours per year.  And you_ don't_ want to be the one people are pointing fingers at when there is a data breach.  So it's really important to understand at least the basics of security - if not all the details, then at least some basic points of entry for hackers.

I've been working on a project for my upcoming presentation (next week!) at the [Flatiron School](http://flatironschool.com), and I decided to use Facebook authentication.  This makes sense because users will generally have Facebook logins already, so the barrier to entry is lowered, and I don't have the responsibility of taking care of a database of user passwords (or password hashes).  However, I needed to take care of a few things in order to make this happen.

<!-- more -->

First, I registered a new app with Facebook.  The process was pretty simple - took me about 3 minutes - and I had an app ID and secret key ready to go.  Then I followed the steps on [this fantastic blog post](https://coderwall.com/p/bsfitw) to integrate Facebook login with my app using OmniAuth and the Facebook OmniAuth gem.  Et voilà, I can seamlessly bring in Facebook users!

However, there was something that still needed to be taken care of to avoid security vulnerabilities popping up.  My config/initializers folder now included 2 files which would be dangerous to expose in public by posting to Github.  These files are:

omniauth.rb - added for use with OmniAuth, it includes the App ID and Secret Key for Facebook)

secret_token.rb - included in a standard Rails app, used to authenticate the session sent by the user

I checked the initialize directory out of version control, since it's mostly standard files, and these were the non-standard files and needed to be secret, there was nothing that desperately needed to be pushed to Github.

But this wasn't ideal either.  Let me explain.

Interestingly, the default code for secret_token.rb includes the following comment: "Make sure your secret_key_base is kept private if you're sharing your code publicly."  So they tell you to hide it, but don't hide it by default.  Why is that?  According to [this Google Groups discussion](https://groups.google.com/forum/#!topic/rubyonrails-core/N2EFnf6X_i4) (and it makes sense when you think about it), hiding the file would then break upload to Heroku or any other service that uses Git for deployment.  So the key is to keep it in .gitignore while you're developing, then add to Git on a deploy.  But then if you continue development, the secret token will be in the commit history, and that will be available on Github!  Major problem.

Well, one solution is to just regenerate the secret key every time you deploy; there is a Rake task for that.  So you could regenerate the secret key, move the master branch ahead by one commit and deploy that, then keep working from the previous commit with the old secret key, so the current secret key doesn't get to Github.  But this is a pain, and an extra step to remember!

New Zealander David Fone [suggests an alternative solution](http://daniel.fone.net.nz/blog/2013/05/20/a-better-way-to-manage-the-rails-secret-token/#comment-902646816): set the secret key manually in testing and development, and set it on the server in production!  How does this look in practice?  Here's your secret_token.rb (updated by me for Rails 4):

``` ruby
if Rails.env.development? or Rails.env.test?
  MyApp::Application.config.secret_key_base = ('x' * 30)
else
  MyApp::Application.config.secret_key_base = ENV['SECRET_TOKEN']
end
```

So whenever you're working on your own computer, the secret token is just a string of 30 'x'es. That seems kinda stupid, but it definitely reminds you, the developer, that whatever secret key you would be using in testing/development just isn't secure. When you move your application to the production environment, you have to then use the host's tools to input or produce a secret token. In the case of Heroku, this is done with one command:

``` bash
$ heroku config:set SECRET_TOKEN=3eb6db5a9026c54...
```
(fill in a full-length secret token, you get the idea)

So now the production code is secure and unexposed, and you can keep developing with your 30x token.

Finally, one important question. Why is all this secret token stuff so important anyway?  By default, Rails stores sessions on the client's computer.  This means that the user can access the session's content, decipher it easily from Base 64 (since it's not encrypted in any way), and potentially modify it before the next request!  Rails avoids this pitfall by having every session end with a digest that is calculated using the session data and the secret token.  So if the user changes the session data, the digest no longer matches the session data, and Rails knows something is fishy.  It's highly unlikely that a user will be able to guess the secret token and create a new digest, so your session is ultimately safe, as long as your secret token hasn't been compromised.  But if someone else finds out the secret token, they can easily modify their sessions and create new digests (though the process to modify a session is still somewhat difficult, but ultimately it's doable).

Either way, it's worth noting that the user is able to see the session information; Rails secret tokens just prevent the user from modifying the session information (e.g. changing the user id) and getting away with it.  So don't store information in the session that you don't want users to see!  In any situation where you might put sensitive information into a session - don't!  Keep it in a database with an easy way to access it based on the information contained in the session.

So the ultimate take-aways are:

1) Authenticating with services that use OmniAuth is very straightforward (though see [here](http://webstersprodigy.net/2013/05/09/common-oauth-issue-you-can-use-to-take-over-accounts/) for a terrifying blog post about how an attacker can use CSRF to take over an account that has internal login plus Facebook login, or any other OmniAuth login)

2) Don't commit your actual production secret token to Github or anywhere else; there are ways to avoid it without too much hassle.

3) Don't store information in the session if having a user see it would constitute a security breach.

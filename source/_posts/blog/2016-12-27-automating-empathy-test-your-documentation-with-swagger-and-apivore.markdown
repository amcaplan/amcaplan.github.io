---
layout: post
title: "Automating Empathy: Test Your Documentation With Swagger and Apivore"
date: 2016-12-27 21:54:20 +0200
comments: true
categories:
- blog
twitter:
  description: Tired of your API docs falling out of date? Force yourself to
    keep them current and keep your users happy!
---

If you're responsible for an API, you may have noticed that API documentation is
painful to keep in sync with your code.  A tremendous amount of cognitive
overhead is added by having to remember everything you've documented and update
it any time a change happens.

Also, you probably fail a lot.  And you're not alone!  Most teams fail miserably
at the task of documentation upkeep.  It reaches the point where you have to
wonder:

1. Is there a problem with the team if we can't get this right?
2. Is this an intractable problem that is destined to plague us, and all API
maintainers, forever?
3. Is the problem with the task itself?

Most of the material you'll find centers around practices that will help the
team prioritize documentation, organize it better, etc.  I think that's a load
of hooey (pardon my French).  Documentation is really hard because we haven't
figured out how to automatically check that it's accurate, and people can't
reasonably be expected to keep it all in our heads.

Until now.

<!-- more -->

### Introducing Swagger

[Swagger](http://swagger.io), also known as OpenAPI, is a nifty tool to help you
write the docs for RESTful APIs.  It ultimately boils down to a JSON endpoint in
your app that spits out a standardized description of how your app works.  This
endpoint is completely independent of the language or framework you use in your
app.

I'll mention at the bottom how you might go about incorporating Swagger into a
Ruby app, but first I want to convince you to use it!  So...

The really cool thing about Swagger isn't the rules, but the power that comes
with following them.  Standards allow us to build powerful shared tools, and
Swagger is a shining example.

Once you've assembled your standardized docs, you can use Swagger Codegen to
spit out generated client libraries for over 40 different languages.  (Warning:
The code will be about as good as you'd expect from generated code.  Sometimes
that's good enough!)  Perhaps more practically, you can plug your docs into
[Swagger UI](http://swagger.io/swagger-ui/), which interprets your docs into a
friendly, human-readable format.  Significantly, Swagger UI allows you to fill
in the expected query/data params and submit an HTTP request, leading to a far
happier experience for whoever has to actually use your API.  You can even
generate OAuth tokens right from the web interface!  Check out a
[sample documentation UI](http://petstore.swagger.io/) to see how much you get
for free by following the Swagger standard.  You can get Swagger UI bundled as
[a Docker image](https://hub.docker.com/r/schickling/swagger-ui/) if you're into
that.  (I am!)

But we haven't even hit the coolest thing about Swagger, which is:

### Documentation as Specification

There are [a host of OSS libraries around Swagger](http://swagger.io/open-source-integrations/)
for nearly any language used in modern web development.  I'll focus on Ruby, but
a quick perusal of the documentation shows that similar tools exists for
JavaScript, Java, Elixir, PHP, and Python.

I'll specifically discuss Apivore, though it's not the only Ruby solution.  Bad
news for MiniTest fans, though: All the current tools for Ruby, including
Apivore, are RSpec-only.

After including the gem, you'll write the basic layout of your Apivore suite:

{% raw %}
```ruby
# Source: https://github.com/westfieldlabs/apivore#usage

require 'spec_helper'

RSpec.describe 'the API', type: :apivore, order: :defined do
  subject { Apivore::SwaggerChecker.instance_for('/swagger.json') }

  context 'has valid paths' do
    # tests go here
  end

  context 'and' do
    it 'tests all documented routes' do
      expect(subject).to validate_all_paths
    end
  end
end
```
{% endraw %}

You feed it the endpoint that serves your documentation, then write specs for
every endpoint in your documentation.  Finally, you specify that all paths have
been tested.  This last spec is really important, because otherwise you might
forget and leave out a path!  It's also nice as a way to test-drive writing
specs for all the routes, since the failure message tells you exactly which
paths and response codes have yet to be tested:

```
the API
  and
    tests all documented routes (FAILED - 1)

Failures:

  1) the API and tests all documented routes
     Failure/Error: expect(subject).to validate_all_paths

       get /posts is untested for response code 200
       post /posts is untested for response code 201
       post /posts is untested for response code 422
       get /posts/{id} is untested for response code 200
       get /posts/{id} is untested for response code 404
       put /posts/{id} is untested for response code 200
       put /posts/{id} is untested for response code 404
       delete /posts/{id} is untested for response code 200
       delete /posts/{id} is untested for response code 410
    # ./spec/requests/api_spec.rb:39:in `block (3 levels) in <top (required)>'
```

Now that you've got a failing test, let's see how to write an Apivore spec.
Remember that the `subject` in every spec is the `Apivore::SwaggerChecker`
instance for your documentation endpoint.  This is important because it keeps
track of validated routes, so it can verify at the end that all routes were
validated.

Here's what a sample spec might look like:

{% raw %}
```ruby
describe 'validating post paths' do
  context 'an individual post' do
    let(:params) {{ "id" => 1 }}
    it { is_expected.to validate( :get, '/posts/{id}.json', 200, params ) }
  end
end
```
{% endraw %}

Here, `params` refers to the dynamic pieces of the requested path, in this case
just the `id` of the requested post.  The `params` hash may also include
information intended for the headers, query string, or data body of the request.
These are specified by special keys, as follows:

{% raw %}
```ruby
describe 'validating post paths' do
  context 'updating a post' do
    let(:params) {{
      "id" => 1,
      "_headers" => { "accept" => "application/json" },
      "_query_string" => "api_key=abcdef123456789",
      "_data" => "This is a post."
    }}
    it { is_expected.to validate( :put, '/posts/{id}.json', 200, params ) }
  end
end
```
{% endraw %}

When you validate a path, Apivore will check that the status code and format of
the response exactly match your Swagger specification, including required keys
and data types.  Any deviance is noted in a failure message with a helpful diff.

### Why Bother?

This may seem like a lot of work.  But you know what's a lot more work?  Dealing
with annoyed customers and clients who find the API doesn't work as expected.

Let me share a personal experience.  I added Apivore to our app a while ago,
thinking it was a neat idea.  I thought it would take me just a couple of days
to get everything in order and build out the test suite.

Wow, was I wrong.  It took a full month.

That's not a matter of how fast I code, but rather because writing the
documentation and testing it this way uncovered a large degree of variance
between our documentation and what the API actually provided.  This, in turn,
was often rooted in differing fundamental assumptions about how things should
work.  Cleaning up all that mess took weeks!  And I'm proud to say with
confidence that we don't have a mess like that anymore, because our "docspecs"
(as I call them fondly) ensure that our docs are always up to date.

You're probably messing up as much as we were.  The scary part is, you don't
know where or how, and even a full manual audit wouldn't prevent it from
happening again.

Rather than driving ourselves crazy keeping code and documentation in sync, why
not leverage our documentation to help us write better code?

### Why Not Use Auto-Generated Docs?

Some will argue that this approach is backwards.  Isn't the code the main thing?
Why do we want to maintain documentation plus specs around it?  There are tools
to derive documentation from our specs or from making API requests, so why not
just use those?

I argue that that approach is actually backwards.  Our documentation should
exactly detail the service we provide to clients and consumers.  Our code is
merely the implementation of that service.  So it makes sense for the
documentation to be the canonical reference, while the code is tested to ensure
it falls in line with the documentation.

Another benefit is that working in this way allows Documentation-Driven
Development, where you make a change to the docs, then let the failing test
drive you to implement the change or new feature.  This leads to much cleaner
design, focused directly on the ultimate value you provide your API clients.
I've found this practice also dramatically speeds up new development on the
project.

### #Protips

There are a few gotchas with Apivore, so let me be upfront and help you make the
most of your docspec experience:

<ol>
<li><p>Apivore doesn't test query parameters.  Sorry.  I've filed a
<a href="https://github.com/westfieldlabs/apivore/issues/91">GitHub Issue</a>
complaining about it, but so far no dice.  I think it would be even more useful
if it did validate query parameters, but I find it pretty awesome even without
that feature.</p></li>

<li><p>Apivore specs need to run using RSpec's <code>defined</code> order,
meaning they'll run from top to bottom every time.  This exposes you to false
success, because you won't detect order-dependent failures.  You can get around
this by running all the endpoint specs within an RSpec <code>context</code> that
uses <code>order: random</code>, so just the last spec will always go last, but
everything else will be randomized.
</li></p>

<li></p>It can get irritating to merge multiple kinds of params every time.  I
use a few <code>let</code> statements for all Apivore specs to help keep
individual specs clean:
{% raw %}
``` ruby
let(:url_params) {{}}
let(:headers) {{}}
let(:query_string_params) {{}}
let(:data_params) {{}}
let(:params) {
  url_params.merge(
    '_headers' => headers,
    '_query_string' => query_string_params.to_query,
    '_data' => data_params
  )
}
```
{% endraw %}
Then, I simply override the special params hashes where necessary.</p></li>

<li><p>You'll find that your Apivore specs quickly become way too big for one file.
I've found RSpec's shared examples work quite well.  First, for semantics, I
aliased <code>it_behaves_like</code> to <code>it_serves_up</code>, so my
endpoint specs look like:</p>
```ruby
context 'has valid paths', order: :random do
  it_serves_up 'posts endpoints'
  it_serves_up 'comments endpoints'
  # etc.
end
```
<p>For organization purposed, I define the shared examples in a
<code>spec/requests/api</code> directory, and make sure they have names that
don't end in <code>_spec.rb</code>.  Finally, I require all those examples
before running my specs:</p>
```ruby
current_dir = File.dirname(File.expand_path(__FILE__))
Dir[current_dir + '/api/*.rb'].each do |file|
  require file
end
```
<p>Now I just defined shared examples in those directories.</p></li>
</ol>

With all these special modifications, here's a sample `spec/requests/api_spec.rb`
for a Rails app:

{% raw %}
```ruby
require 'rails_helper'

current_dir = File.dirname(File.expand_path(__FILE__))
Dir[current_dir + '/api/*.rb'].each do |file|
  require file
end

RSpec.describe 'the API', type: :apivore, order: :defined do
  subject { Apivore::SwaggerChecker.instance_for('/api/docs.json') }
  let(:query_string_params) {{
    api_key: client.api_key
  }}
  let(:url_params) {{}}
  let(:headers) {{}}
  let(:query_string_params) {{}}
  let(:data_params) {{}}
  let(:params) {
    url_params.merge(
      '_headers' => headers,
      '_query_string' => query_string_params.to_query,
      '_data' => data_params
    )
  }

  context 'has valid paths', order: :random do
    it_serves_up 'posts endpoints'
    it_serves_up 'comments endpoints'
  end

  context 'tying it all together' do
    it 'tests all documented routes' do
      expect(subject).to validate_all_paths
    end
  end
end
```
{% endraw %}

with actual specs defined in shared examples elsewhere.

### How Do I Get Started?

Luckily this isn't too complicated, and there's plenty of Googlable help.  You
have 2 basic approaches: Either integrate deeply with your programming language,
or just edit the JSON directly (or edit as YAML).  In the case of Ruby,
[`swagger-blocks`](https://github.com/fotinakis/swagger-blocks) seems to be a
popular solution, and we've found it useful.  It's pretty low-level, though, and
there are other solutions which might work better as higher-level constructs
depending on which framework you use.  The Swagger site maintains
[a useful list of language-specific tools](http://swagger.io/open-source-integrations/).

I've seen another team just use the [Swagger editor](http://editor.swagger.io)
to edit their specification, and it works well for them.

There isn't a right answer here; it all depends on whether you prefer the docs
to live closer to or further from your code.

There is a learning curve to understand how to use Swagger, but the tooling is
fantastic, which helps a lot.  I'd recommend looking at a sample specification
to get a feel for it, then edit to match your own API.

### A Shift in Perspective

Working with Swagger has changed how I think about the API I work on every day.
I often used to fall into the trap of thinking we're building it to build it,
and the documentation is "just for the users."

Following a Documentation-Driven Development path with Swagger and Apivore, I've
found that the user is brought to the forefront.  Everything we build is in
service of the product, as described in the Swagger specification, and our
docspec suite ensures we don't let our users down.

Part of the reason teams have trouble with documentation is that the users are
relegated to an afterthought.  It's difficult to develop empathy for them when
their mental model of the app is likely so far removed from our own.

By enforcing accurate documentation, we ensure that we've specified a full
explanation of what the user can expect from our API.  Since we're also
responsible for maintaining that explanation, it becomes a tool to change us,
helping us maintain a user-centric design approach.  No longer do we build
features and then expose them to the user; instead, we start with the allowed
requests, then build the implementation beneath the surface.  Starting the
development process from the user's vantage point leads to cleaner APIs, a
better user experience, and ultimately happier customers.

***Written as part of the 2016 [8 Crazy Blog Posts Challenge](/blog/2016/12/25/8-crazy-blog-posts).***

---
layout: post
title: "Speeding up a Simple Static Site (With Help from Cloudinary!)"
date: 2019-01-20 15:09:04 +0200
comments: true
categories: 
- blog
tags:
- Cloudinary
- images
- CDN
twitter:
  description: Making static sites performant on many devices doesn't have to be
    a pain. A few simple steps can make a big difference!
---

### Diagnosing The Patient
For the last 2 years, I've run [Dev Empathy Book Club](https://devempathybook.club),
and the site hasn't changed much. I've tried to keep it low-effort so I can focus
on the community and the content we're producing. One casualty of this was that
the site, while simple, wasn't very performant. (Google's
[PageSpeed Insights](https://developers.google.com/speed/pagespeed) gave it a
very low score of 30/100 on mobile.)

I recently began working at [Cloudinary](https://cloudinary.com), and I realized
it's pretty embarrassing that, as an employee of a company whose product is all
about optimizing media on the web, I have a personal site that does a terrible
job of it.

<!-- more -->

The final bit of encouragement came from fellow Cloudinarian
[Eric Portis](https://twitter.com/etportis), who published [an article](https://www.smashingmagazine.com/2017/07/website-speed-test-image-analysis-tool/)
about [Website Speed Test](https://webspeedtest.cloudinary.com/), a free tool
from Cloudinary to grade image performance on your site. When I ran it against
the Dev Empathy Book Club site, I saw that users had to download 1.5MB, which
could be optimized down to 370kB, i.e. about 1/4 of their weight. I also knew
these images were being served directly from GitHub Pages, without any CDN, so
on mobile devices the page load was pretty slow.

On top of all this, there was a good amount of render-blocking JS and CSS being
downloaded without a CDN.

All this meant slower load times, and lower scores in search results. There was
no good reason for it, except that I didn't have the know-how to improve things,
or the time to learn how to do it.

### Enter Cloudinary
Cloudinary is a really straightforward service to upload, transform, and serve
images and videos. The free tier contains way more than you'll ever need for a
simple static site, so it's a great choice for e.g. personal sites with a few
images you'd like to serve efficiently.

One awesome feature of Cloudinary which made this incredibly simple is the
ability to [auto-fetch images](https://cloudinary.com/documentation/upload_images#auto_fetching_remote_images).

For example, consider this URL:

```
https://res.cloudinary.com/caplan/image/fetch/https://amcaplan.ninja/images/ninja-cropped.png
```

The URL consists of

```
https://res.cloudinary.com/caplan/image/fetch/
```

which tells Cloudinary you want to fetch an image for the `caplan` cloud, and
the rest is the URL where the image can be found:

```
https://amcaplan.ninja/images/ninja-cropped.png
```

When you hit this URL, Cloudinary will fetch the image in the background, and
begin serving via CDN.

Theoretically we could take all the images on the site and preface with the fetch
incantation, but there's a better way. Cloudinary has another feature called
Auto Upload, which lets you create folders which are proxies for web locations.
So if we create a `ninja_images` directory mapped to `https://amcaplan.ninja/images/`,
the URL looks like this:

```
https://res.cloudinary.com/caplan/image/upload/ninja-images/ninja-cropped.png
```

Much better! Here's the result:

![ninja image served via Cloudinary](https://res.cloudinary.com/caplan/image/upload/ninja-images/ninja-cropped.png)

Now comes the fun part.

Cloudinary lets you edit images by adding transformations right into the URL.
For example, by adding `/w_100` before the image location, we creates a
100-pixel-wide version of the same image:

```
https://res.cloudinary.com/caplan/image/upload/w_100/ninja-images/ninja-cropped.png
```

![small ninja image](https://res.cloudinary.com/caplan/image/upload/w_100/ninja-images/ninja-cropped.png)

You can also crop, set gravity (focusing on a region of the image or on human
faces), scale, add text layers or image overlays, and do a whole bunch more
awesome stuff, just by adding to the URL.

This opens up the opportunity to create multiple versions for various
breakpoints, driven via CSS. So if you take a large version as the original,
you can tell Cloudinary to crop/scale the image as you see fit, no Photoshop
skills required!

As one concrete example, here's a large image for wide screens:

```
https://res.cloudinary.com/dev-empathy-book-club/image/upload/f_auto,q_auto/site/slider-bg.jpg
```

![large image of girls holding hands](https://res.cloudinary.com/dev-empathy-book-club/image/upload/f_auto,q_auto/site/slider-bg.jpg)

You'll notice a couple transformations here: `f_auto`, which chooses the most
bandwidth-optimized image format for the user's browser, and `q_auto`, which
reduces image size by degrading image quality without being noticeable to the
human eye.  Those 2 transformations already reduce the image size from 874kB to
385kB, without any noticeable difference to the user!

But we can do better on mobile, where this many pixels still aren't helping
anyone. Here's a scaled-down version for mobile:

```
https://res.cloudinary.com/dev-empathy-book-club/image/upload/f_auto,q_auto,w_480,h_800,c_lfill,g_auto/site/slider-bg.jpg
```

![small image of girls holding hands](https://res.cloudinary.com/dev-empathy-book-club/image/upload/f_auto,q_auto,w_480,h_800,c_lfill,g_auto/site/slider-bg.jpg)

In this case, we're creating a tall image bounded at 480px width, centered on
what Cloudinary determines to be the most interesting part of the image, and
using a `fill` approach to the crop (expressed as `c_lfill`) to ensure we cover
the entire requested dimensions of 480x800.

There are many parameters and even more options for those parameters, but the
[documentation](https://cloudinary.com/documentation/image_transformations) is
quite thorough and the system is really powerful.

To see a real-life example for what this might look like, check out [the CSS for
Dev Empathy Book Club's site on GitHub](https://github.com/dev-empathy-book-club/dev-empathy-book-club.github.io/blob/d78cf21daaa53ffe1d82059dadc3316fcccb9fa5/css/airspace.css#L866-L940).

### The Gravatar Challenge
At first I assumed that [Gravatars](https://www.gravatar.com) (we display a few)
on the site would work the same way, but I soon realized there is a big problem
with Gravatar. The URL for an image looks something like this:

```
http://secure.gravatar.com/avatar/7b5a451ee25044b9c869e3e98b79425d.jpg?s=200
```

with this result:

![Ariel Caplan 200-pixel gravatar](http://secure.gravatar.com/avatar/7b5a451ee25044b9c869e3e98b79425d.jpg?s=200)

If I want a larger version, I just change the `s` query param. So for a 400px
square, I'd use this URL:

```
http://secure.gravatar.com/avatar/7b5a451ee25044b9c869e3e98b79425d.jpg?s=400
```

![Ariel Caplan 400-pixel gravatar](http://secure.gravatar.com/avatar/7b5a451ee25044b9c869e3e98b79425d.jpg?s=400)

Lacking the `s` parameter, Gravatar defaults to an 80px square:

```
http://secure.gravatar.com/avatar/7b5a451ee25044b9c869e3e98b79425d.jpg
```

![Ariel Caplan 80-pixel gravatar](http://secure.gravatar.com/avatar/7b5a451ee25044b9c869e3e98b79425d.jpg)

If you try to fetch a large Gravatar avatar with Cloudinary, here's the result:

```
https://res.cloudinary.com/caplan/image/fetch/https://secure.gravatar.com/avatar/7b5a451ee25044b9c869e3e98b79425d.jpg?s=400
```

![Ariel Caplan 80-pixel gravatar fetched through Cloudinary](https://res.cloudinary.com/caplan/image/fetch/https://secure.gravatar.com/avatar/7b5a451ee25044b9c869e3e98b79425d.jpg?s=400)

What happened? Cloudinary treats `?s=400` as a meaningless parameter passed to
Cloudinary, and doesn't forward it to Gravatar.

It turns out that someone at Cloudinary thought of this, and therefore built
[Gravatar support](https://cloudinary.com/blog/placeholder_images_and_gravatar_integration_with_cloudinary)
directly into the platform. Unlike the `fetch` and `upload` image types we've
seen so far, there's also a `gravatar` image type which knows how to source a
high-quality image from Gravatar, and even update it automatically (with a small
delay) when someone changes their avatar!

If you fetch images via Gravatar in this way, you can easily scale up or down
using the normal `h_` and `w_` parameters. So here's that same 400px image of
yours truly, fetched via Cloudinary:

```
https://res.cloudinary.com/caplan/image/gravatar/w_400/7b5a451ee25044b9c869e3e98b79425d.jpg
```

![Ariel Caplan 400-pixel gravatar fetched through Cloudinary](https://res.cloudinary.com/caplan/image/gravatar/w_400/7b5a451ee25044b9c869e3e98b79425d.jpg)

Of course, once you've done this, you can use `f_auto` and `q_auto` to optimize
images further and reduce bandwidth use. Neat!

### Not Just for Images!
One little-known fact about Cloudinary: They can serve anything via CDN, not just
images and video! So if you have JS or CSS files, you can serve them through
Cloudinary's CDN in the same fashion as mentioned above for images: Set up an
Auto Upload folder and reference those URLs instead of the place where they're
hosted on your site. So for example, instead of:
```
https://devempathybook.club/css/bootstrap.min.css
```
we reference:
```
https://res.cloudinary.com/dev-empathy-book-club/raw/upload/css/bootstrap.min.css
```
(where `css/` is a folder mapped to `https://devempathybook.club/css/`). Note
that instead of `image` as before, we write `raw` to indicate that this should
be considered an unknown file type and Cloudinary shouldn't try to do any image
processing with it.

Usually you'll want to use a [versioning strategy](https://css-tricks.com/strategies-for-cache-busting-css/#article-header-id-2)
for your JS and CSS assets if you use a CDN, but the goal here was to be lazy on
a static Jekyll site. Since there wasn't much custom CSS and JS, I simply left a
few files that are loaded directly from the site, but things that won't change
frequently (or ever) are served via CDN. You can see the code
[here](https://github.com/dev-empathy-book-club/dev-empathy-book-club.github.io/blob/d78cf21daaa53ffe1d82059dadc3316fcccb9fa5/_includes/head.html#L36-L56).

### Cut Waste
You might notice, if you looked at the code from the last section, that a number
of lines were commented out. It turns out that the Jekyll template I used bundled
with it a number of JS/CSS frameworks and plugins I didn't actually use. Removing
them reduced the total page load size, and makes the page run faster, since
there's a smaller load on the CPU. As they say, no code is faster than no code!

### The Outcome
I wouldn't call the site blazing-fast now, but its PageSpeed mobile score went
up from 30 to 50 in a few simple steps taking a couple hours total. There are
more things to optimize, but these quick tricks helped bring down page load time
a lot already. Importantly, time to first paint on mobile was cut by about 50%.
That's a much better experience for mobile users.

So go out, try these tips, and let me know in the comments how you did!

As a reminder, I work at Cloudinary, so if you do find anything here difficult
to implement, I can pass along your concerns to the right people... 😉

_NOTE: Cloudinary did not ask me to write this. Nothing in this post should be
taken as representing anyone other than myself._

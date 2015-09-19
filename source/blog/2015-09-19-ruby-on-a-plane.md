---
title: "Ruby on a Plane"
date: 2015-09-19 16:00
comments: true
tags: login, ruby
---

In the past few years I've spent an awful lot of time at airports, on airplanes, and in trains. I love my job, it gets me to places I never would have dreamed I'd ever go, but it can be damn hard on someone who needs a decent wifi connection to do be productive.

I've learned some tricks to keep me going in these situations, working on new and existing Ruby/Rails apps in airport lounges, hotel lobbies, and on airplanes.

## Prerequisites

Most of the tips below assume that you mostly use the same stack in every project. I know I do and I try to keep my projects up to the latest Rails version as much as I can. In all reality though, the tips below should even work in more complex situations.

The tricks also assume you have at least worked on any of your existing projects before getting on the plane. This is because this will allow you to use installed gems. My main assumption is that you rarely would ever want to use a gem you don't already have on your machine.

In my environment I don't use *gemsets*. I do use [rbenv](https://github.com/sstephenson/rbenv) to manage my Rubies, and I tend to use the same Ruby across my projects.

## A new Rails project

Assuming you have the `rails` gem installed you can create a new project without an internet connection using the `-B` or `--skip-bundle` flag to skip bundling.

```shell
rails new -B project_name
```

The nice thing is that this automatically creates a `Gemfile.lock` so you can instantly use the project even without bundling!

To make this the default for every project just add the `-B` to your `~/.railsrc`.

## Adding a gem to a project

Now if you're like me then a generic Rails setup won't do. Just add a gem to your `Gemfile` and bundle with the `--local` flag.

```shell
bundle install --local
```

According to the docs this flag tells bundler: "Do not attempt to connect to rubygems.org, instead using just the gems already present in Rubygems' cache or in vendor/cache. Note that if a more appropriate platform-specific gem exists on rubygems.org, it will not be found."

Interestingly though this also seems to work for alternative sources like the fabulous [rails-assets.org](http://rails-assets.org).

## Updating a gem

Want to update an older gem to a newer version? Do you have the newer version installed locally already? Just update with bundler using the same flag.

```shell
bundle update rails --local
```

To quickly inspect what gems are available locally just use this command.

```shell
gem list --local
```

## Frontend assets

As I said before, rather than using CDN'ed versions of Bootstrap, jQuery, and other frontend assets I tend to rely on [rails-assets.org](http://rails-assets.org) for my asset management. This amazing platform bridges [bower](http://bower.io/) with Rails and allows you to use the same tricks as above to reuse these assets that you already have installed locally.

## Offline Google fonts

I personally love using Google Fonts and keeping your mac in sync so you have the fonts installed locally (and offline) can be hard. I use [SkyFonts](http://www.fonts.com/web-fonts/google) to sync my Google fonts to my mac. You can use this tool to sync fonts from Google, [fonts.com](http://fonts.com) and many more providers.

## Offline documentation

I really love the [Dash app](https://kapeli.com/dash) for having offline documentation. I'm pretty bad at remembering every little Ruby method in the standard library so this is quite essential. Dash is not Ruby or Rails specific so make sure to load up your JS, CoffeeScript, SASS, LESS, and other references as well.

---

title: "Your mini-Heroku with Dokku and Dokkufy"
date: 2014-08-05 22:16
comments: true
tags: ruby gem dokku
---

I've always enjoyed [Heroku](http://heroku.com) but there are plenty of reasons both monetary and practical not to use it. I always liked the deployment method through Git though.

So this weekend at [LeedsHack](http://leedshack.org) I started to look into [Dokku](https://github.com/progrium/dokku), an open source mini-Heroku powered by [Docker](https://www.docker.com/), [Buildstep](https://github.com/progrium/buildstep) and some other bits that share infrastructure elements with Heroku.

I found the installation rather tedious and as this was a hackathon I decided to create something simpler.

## Introducing Dokkufy

[Dokkufy](https://github.com/cbetta/dokkufy) is a Ruby gem that makes it super simple to set up your own mini-Heroku on your own server.

Simply install with a swift `gem install dokkufy` and you're ready to "dokkufy" both your server and your app.

### Part 1: Dokkufying your server

Dokku only works with Ubuntu 12.04 and 14.04 server, so go get one of those images and boot up a server.

Then on your local machine run:

<script src="https://gist.github.com/cbetta/995577526584091c1e31.js"></script>

As you can see this will ask you for a few details: server name or IP, username, and the eventual server domain to run all apps under. After a few minutes, depending on your broadband speeds, you will have a Dokku server ready do go.

Open up your server's domain or IP in a browser and voila!

![Nginx](/images/blog/2014/nginx.png)

### Part 2a: Dokkufying your app

Now that we have a Dokku server ready to go it's time to prepare your app.

I used the [Heroku Node JS sample app](https://github.com/heroku/node-js-sample) for my example.

<script src="https://gist.github.com/cbetta/50149a1b60d47ba91f28.js"></script>

As you can see this simply asks for the details of your server and then adds a Git remote and writes a `.dokkurc` file to your app.

Now do a `git push dokku master` and you will see your app deployed.

<script src="https://gist.github.com/cbetta/f5379254e1563f00c7ae.js"></script>

Dokku will automatically create your project for you on first push and deploy your app to a subdomain of your chosen domain. In this case we deployed our app to [http://node-js-sample.ppd.io](http://node-js-sample.ppd.io).

### Part 2b: Controlling Dokku

When you install Dokku on your server it gives you some handy commands. Sadly to run those from your local machine you need to perform some ssh-fu.

So to make this easier Dokkufy also comes with a local `dokku` command. You can use this command in any dokkufied app that has a `.dokkurc` file. It will automatically use that file to infer the remote server details and your app name.

<script src="https://gist.github.com/cbetta/b1ffe8aca4f571fbbd21.js"></script>
&nbsp;

### Some final notes

That's it for Dokkufy. I recommend running `dokkufy help` to see how you can explore and install plugins to install things like Postgres, Redis, and other features on your machine.

I also want to thank the awesome [Jeff Lindsay](https://github.com/progrium) for his work on Dokku and I want to highlight what seems to be the next iteration of Dokku: [Flynn](https://flynn.io/).

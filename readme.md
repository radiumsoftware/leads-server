# Radium Lead Capture

This repo contains everything you need to get lead capture working on
your Company's website. It contains a simple server to host the form and
an example to you setup your own.

## Background

The Radium lead capture API is based around contacts. Each account in
Radium has a unique token. You need this token to use the lead capture
api. You find your token on the settins page in Radium or by contacting
the support team. You should keep is token secret. Anyone who knows the
token can add people into your account! For this reason, we've made an
example server that proxie's the Radium API. This way only you know your
token and it's kept out of public files.

## Up and Running

The first thing you want to do is clone this repo for yourself. By
running this command:

    git clone git://github.com/radiumsoftware/leads-server.git

This will give you a local copy of the current code. Now you can
run through the basic setup:

```
# Install Ruby
$ gem install bundler
$ bundle
```

Open up `config.ru` in an editor and insert your token as shown.

```ruby
LeadServer.token = ENV['RADIUM_ACCOUNT_TOKEN'] || "sandbox" # replace
"sandbox" with your own
```

At this point you should be ready to start the server. You can run the
server locally to test out your form and to add leads to your account.

Start the server with:

`bundle exec rackup`

This will start a local server on port 9292. You can vist the server by
opening `http://localhost:9292` in your browser. Follow the instructions
on screen to get started.

## Implementing Your Own Form

The proxy server will return JSON from the server. You can use reponse
code to determine if the submit worked or not. The server will also
validate data. It **will not** accept invalid data. It's up to you
figure out how you want to handle your UX. This code simply gives you
the framework to implement your own UX once you have the proper form
HTML ready.

## Deploying

You can deploy the lead proxy server to Heroku for free. Or, you can
host it yourself. We recommned deploying to heroku because it's free,
easy, and keeps your token safe. All you have to do is take your HTML
and point the form action to the url on Heroku. You can deploy this code
in a few simple commands one you have your Heroku account setup.

```
$ heroku create --stack cedar
$ heroku config:add RADIUM_ACCOUNT_TOKEN=INSERT_YOUR_TOKEN_HERE
$ git push heroku master
```

Heroku will give you a URL that you can point your form to.

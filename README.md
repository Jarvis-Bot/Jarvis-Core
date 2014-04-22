[![Build Status](https://travis-ci.org/Jarvis-Bot/Jarvis-Core.svg?branch=master)](https://travis-ci.org/Jarvis-Bot/Jarvis-Core) [![GitHub version](https://badge.fury.io/gh/jarvis-Bot%2FJarvis-Core.svg)](http://badge.fury.io/gh/jarvis-Bot%2FJarvis-Core) [![Dependency Status](https://gemnasium.com/Jarvis-Bot/Jarvis-Core.svg)](https://gemnasium.com/Jarvis-Bot/Jarvis-Core) [![Coverage Status](https://coveralls.io/repos/Jarvis-Bot/Jarvis-Core/badge.png)](https://coveralls.io/r/Jarvis-Bot/Jarvis-Core)

Jarvis
===========================

What is it?
------------

**Jarvis** is a very flexible bot, operating with multiple sources, to do stuff for you.

Hmm, tell me more?
-------------------

Okay, so imagine, you're connecting **Jarvis** to Twitter via his specific account. You could mention him and tell this kind of stuff :
```
  @NAMEBOT : uptime                              => 6 days, 4 hours, 3 minutes and 45 seconds
  @NAMEBOT : alarm 6:15                          => Alarm set to 6:15
  @NAMEBOT : download http://domain.tld/file.jpg => Downloaded file.jpg at Jarvis/downloaded_files/
  @NAMEBOT : next birthday                       => Steve Adam will be the next one, on 7th october !
  @NAMEBOT : reminder buy milk @ 18:00           => I will remind you to buy milk at 18:00
```
But, there's more! You could connect it to Github, Travis-CI, Instagram, Facebook, Email, Tumblr... And it will just execute what you need!

What about publishing every Instagram pic you post on Tumblr, saving them in local, and sending it to your mum via mail?
Or receiving a failed notification from Travis-CI, playing an alarm sound on your computer/homeserver, and blinking every Philips Hue in your house/office?

You can define every possible case.

How does it work?
------------------
**Jarvis** relies on three types of plugins:

* `Sources` : Feed **Jarvis** with data from anywhere / anything
* `Receivers` : Handle this data and execute stuff
* `Clients` : Give ability to interact with services, like Twitter, Github... to `receivers`

Run
---

`~$ cd Jarvis/bin/`
`~$ ./jarvis`

Plugins
-------

The power of **Jarvis** belongs to you, developpers!
If you want to create a `source`, a `receiver` or a `client`, take a look at the documenation (not available atm).

Temp documentation
------------------
To create any plugin, you have to do this :

* Host your plugin on github.com
* Create these following files at the root:
    * specs.yml
    * init.rb

Each type of plugins has what is below in common. Every field with an `*` is required by **Jarvis**
Of course, you've to remove the `*` and what's written between brackets when you're writing your specs.yml file.

```
author:
  name*: "Victor Bersy"
  mail: "victor.bersy@gmail.com"
  contacts:
    github: "VictorBersy"
    twitter: "VictorBersy"

specs:
  type*: "source" [source, receiver, client]
  name*: "Twitter" [trimmed after 15 char]
  version: "0.1"
  description: "Interact with Jarvis via Twitter."
  keywords: [twitter, tweet]
  homepage: "https://github.com/Jarvis-Bot/twitter-source"
  license:
    type: "MIT"
    url: "https://github.com/Jarvis-Bot/twitter-source/LICENSE"
  repository:
    type: "git"
    url: "https://github.com/Jarvis-Bot/twitter-source.git"
  color message: "#55ACEE" [If it's not specified, Jarvis will generate one for you. Use main color of the service if possible]
```

Some fields are only required for specific plugins:

### Sources
Add this at the end of your `specs.yml` file:
```
source:
  class name: "TwitterSource"
```
It must be the class name of your `init.rb` file. It will be called by Jarvis on boot, and executed in his specific thread.

### Receivers
Add this at the end of your `specs.yml` file:
```
receiver:
  class name: "TwitterReminder"
  handle: [Twitter]
```
It must be the class name of your `init.rb` file. It will be called by Jarvis when one of your triggers is detected.

### Clients
(Not tested at the moment)


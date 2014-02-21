Jarvis [WIP] [![Build Status](https://travis-ci.org/VictorBersy/Jarvis.png?branch=master)](https://travis-ci.org/VictorBersy/Jarvis) [![GitHub version](https://badge.fury.io/gh/VictorBersy%2FJarvis.png)](http://badge.fury.io/gh/VictorBersy%2FJarvis) [![Dependency Status](https://gemnasium.com/VictorBersy/Jarvis.png)](https://gemnasium.com/VictorBersy/Jarvis) [![Coverage Status](https://coveralls.io/repos/VictorBersy/Jarvis/badge.png)](https://coveralls.io/r/VictorBersy/Jarvis)

===========================

## What is it ?

**Jarvis** is a Twitter bot. I craft it to make it my assistant. It's perfect to run on your own server.

## Examples (coming soon)
```
  @NAMEBOT : uptime                              => 6 days, 4 hours, 3 minutes and 45 seconds
  @NAMEBOT : alarm 6:15                          => Alarm set to 6:15
  @NAMEBOT : download http://domain.tld/file.jpg => Downloaded file.jpg at Jarvis/downloaded_files/
  @NAMEBOT : next birthday                       => Steve Adam will be the next one, on 7th october !
  @NAMEBOT : reminder buy milk @ 18:00           => I will remind you to buy milk at 18:00
```
## Run

`~$ cd Jarvis/bin/ && ./jarvis`

## Plugins

The power of Jarvis belong to you, devs. I tried to make a simple way to create plugins for it.

To create a plugin, you've to :

1. Create a folder under `/plugins/`
2. Create a file called `init.rb`
3. Write a class with the same name as the previous created folder and inherit it from `Jarvis::Plugin`
4. Create a method called `init` with a `message` argument
5. Create a `plugin.yml` file at the root of your plugin folder. Only Author/name, Plugin/name, Plugin/version, Plugin/triggers and Plugin/auth are required to be filled at the moment.

Take example on the HelloWorld plugin. I'll create a plugin generator in CLI soon.

Jarvis will send a message(tweet, DM, reply...) to your plugin in a hash if one of your trigger word is detected.

You've to use Jarvis::Plugin if you want to create an update or anything. It's the REST client from the twitter gem by sferik (sferik/twitter)

It's a Work In Progress, it's really messy, it's my first Ruby project, I hope you'll give me advice and improve this powerful Twitter bot.

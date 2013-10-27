Jarvis [WIP]
=========================== 

## What is it ?

**Jarvis** is a Twitter bot. I craft it to make it my assistant. It's perfect to run on your own server.

## Examples

	@NAMEBOT : uptime                              => 6 days, 4 hours, 3 minutes and 45 seconds
	@NAMEBOT : alarm 6:15                          => Alarm set to 6:15
	@NAMEBOT : download http://domain.tld/file.jpg => Downloaded file.jpg at Jarvis/downloaded_files/
	@NAMEBOT : next birthday                       => Steve Adam will be the next one, on 7th october !
	@NAMEBOT : reminder buy milk @ 18:00           => I will remind you to buy milk at 18:00

## Run

`~$ cd Jarvis/bin/ && ruby jarvis.rb`

## Plugins 

You'll be able to create your own Plugins. I'm still thinking about the architecture. It should be really simple for you, developpers.

**UPDATE** Actually, you can start to create your own plugins. Jarvis is released with two demo plugins : HelloWorld and SpeedTest.
HelloWorld is a simple example of how to make a plugin.
You must create a folder with the name of your choice in `Jarvis/plugins/` and a file called `plugin.yml `. Copy / paste example files, and fill them with your own values.

It works like that : 

1. Loading plugins
2. Initiliazing REST and Streaming clients
3. Waiting for a tweet
4. Once Jarvis receives a tweet, it checks for a trigger word (defined in plugin.yml)
5. It sends it to your receiver file (also defined in plugin.yml). Jarvis creates an instance of your class, and gives these arguments : Answer_instance, tweet Object and which trigger word has been detected.
6. Do your stuff, and use Answer_instance to reply

It's a Work In Progress, it's really messy, it's my first Ruby project, I hope you'll give me advice and improve this powerful Twitter bot.
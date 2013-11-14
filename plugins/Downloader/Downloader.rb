require 'open-uri'
class Downloader
  def initialize(args)
    @answer           = args[:answer_instance]
    @tweet            = args[:tweet]
    @trigger_detected = args[:trigger_detected]
    self.prepare_download
  end

  def prepare_download
    uris = @tweet.uris
    url = uris[0][:expanded_url].to_s

    name = url.split("/").last

    self.download(url, name)
  end

  def download(url, name)
    open(url) {|f|
      File.open(name, "wb") do |file|
        file.puts f.read
      end
    }
    self.reply_ok(name)
  end

  def reply_ok(name)
    @answer.reply(@tweet.user.screen_name, "I successfully downloaded '#{name}' !", @tweet.id)
  end
end
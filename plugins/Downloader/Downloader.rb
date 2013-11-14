require 'open-uri'
class Downloader
  def initialize(answer_instance, tweet, trigger_detected)
    @answer           = answer_instance
    @tweet            = tweet
    @trigger_detected = trigger_detected
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
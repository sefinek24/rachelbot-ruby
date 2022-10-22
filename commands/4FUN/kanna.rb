require 'open-uri'

class CommandKanna
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  def initialize
    @name = "kanna"
    @description = "Losowe zdjęcia z Kanną."
    @usage = nil
  end

  def run(event, args)
    response = URI.open("https://nekobot.xyz/api/image?type=kanna")
    json = JSON.parse(response.read)

    event.channel.send_embed do |embed|
      embed.color = json['color']
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: json['message'])
    end
  end
end
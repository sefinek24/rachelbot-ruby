require 'open-uri'

class CommandNeko
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  def initialize
    @name = "neko"
    @description = "Losowe zdjęcia catgirlów."
    @usage = nil
  end

  def run(event, args)
    response = URI.open("https://nekobot.xyz/api/image?type=neko")
    json = JSON.parse(response.read)

    event.channel.send_embed do |embed|
      embed.color = json['color']
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: json['message'])
    end
  end
end
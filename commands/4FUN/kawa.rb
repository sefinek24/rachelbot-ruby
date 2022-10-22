require 'open-uri'

class CommandKawa
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  def initialize
    @name = "kawa"
    @description = "Losowe zdjęcia postaci z anime pijących kawę."
    @usage = nil
  end

  def run(event, args)
    response = URI.open("https://nekobot.xyz/api/image?type=coffee")
    json = JSON.parse(response.read)

    event.channel.send_embed do |embed|
      embed.color = json['color']
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: json['message'])
    end
  end
end
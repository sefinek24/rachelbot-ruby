require 'open-uri'

class CommandJedzenie
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  def initialize
    @name = "jedzenie"
    @description = "Losowe zdjęcia z posiłkiem."
    @usage = nil
  end

  def run(event, args)
    response = URI.open("https://nekobot.xyz/api/image?type=food")
    json = JSON.parse(response.read)

    event.channel.send_embed do |embed|
      embed.color = json['color']
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: json['message'])
    end
  end
end
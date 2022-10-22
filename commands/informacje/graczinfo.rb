class CommandGraczinfo
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  STATUS = { online: "Dostępny", offline: "Niedostępny", idle: "Zaraz wracam", dnd: "Nie przeszkadzaj" }.freeze

  def initialize
    @name = "graczinfo"
    @description = "Informacje o wymienionym użytkowniku"
    @usage = "[@Gracz]"
  end

  def is_number?(string)
    true if Float(string)
  rescue StandardError
    false
  end

  def run(event, args)
    user = event.server.member(event.message.mentions[0])
    user ||= event.bot.users[event.content.split(" ")[0].to_i] if is_number?(event.content.split(" ")[0])
    user ||= event.message.author

    authorAvatarURL = Discordrb::Webhooks::EmbedImage.new(url: user.avatar_url)

    event.channel.send_embed do |embed|
      embed.color = "#00FF00"
      embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "Informacje o użytkowniku " + user.username, icon_url: event.server.icon_url)
      embed.title = "» Link do Awatara"
      embed.url = user.avatar_url
      embed.add_field(name: "» Nick gracza", value: user.distinct, inline: true)
      embed.add_field(name: "» Identyfikator", value: user.id, inline: true)
      embed.add_field(name: "» Status", value: STATUS[user.status], inline: true)
      embed.add_field(name: "» Pseudonim", value: user.nickname || "❎ Brak", inline: true)
      embed.add_field(name: "» Bot?", value: user.bot_account? || "❎ Nie", inline: true)
      embed.add_field(name: "» Twórca serwera?", value: user.owner? ? "✅ Tak" : "❎ Nie", inline: true)
      embed.add_field(name: "» W grze", value: user.game || "❎ Nie", inline: true)
      embed.add_field(name: "» Najwyższa rola", value: user.highest_role ? user.highest_role.name : "❎ Nie ma", inline: true)
      embed.add_field(name: "» Data utworzenia konta", value: user.creation_time.strftime("%H:%M:%S, %d.%m.%Yr.") + " **(#{(Time.now - user.creation_time).to_i / (24 * 60 * 60)} dni temu)**")
      embed.add_field(name: "» Data dołączenia na serwer", value: user.joined_at.strftime("%H:%M:%S, %d.%m.%Yr.") + " **(#{(Time.now - user.joined_at).to_i / (24 * 60 * 60)} dni temu)**", inline: true)
      embed.thumbnail = authorAvatarURL
    end
  end
end
class CommandPomoc
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  def initialize
    @name = "pomoc"
    @description = "Polecenie pomocy"
    @usage = nil
  end

  def run(event, args)
    avatarURL = Discordrb::Webhooks::EmbedImage.new(url: event.bot.profile.avatar_url)

    event.channel.send_embed do |embed|
        embed.color = "#FEDDA8"
        embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "Witaj, nazywam się Rachel", icon_url: event.author.avatar_url)
        embed.description = "» Jestem nowym botem napisanym w języku RUBY.\n» Główny bot: [LabyBOT](https://labybot.pl)\n» Dodaj mnie na swój serwer! Kliknij [tutaj](https://discord.com/api/oauth2/authorize?client_id=730660687969386556&permissions=8&scope=bot)!"
        embed.add_field(name: "📝  **Statystyki**", value: "» 🌐 **Serwery:** `#{event.bot.servers.size}` || 👤 **Użytkownicy:** `#{event.bot.users.size}`")
        $command_manager.categories.each do |category|
          embed.add_field(
            name: "📑  **#{category.capitalize}**", 
            value: $command_manager.commands.select { |_, cmd| cmd.category == category && cmd.name != "pomoc" }.values.map { |command| "» **#{command.usage}** - " + command.description }.join("\n")
          )
        end
        embed.add_field(name: "😇  **Ostatnie wydarzenia **", value: "» Bot jest bardzo nowy i na tę chwilę posiada bardzo małą ilość komend. Ich ilość niedługo wzrośnie!")
        embed.thumbnail = avatarURL
    end
  end
end
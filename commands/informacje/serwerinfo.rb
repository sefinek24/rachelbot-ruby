class CommandSerwerinfo
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  REGIONNAME = { "brazil" => ":flag_br:", "europe" => ":flag_eu:", "eu-central" => ":flag_eu:", "hongkong" => ":flag_hk:", "india" => ":flag_in:", "japan" => ":flag_jp:", "russia" => ":flag_ru:", "singapore" => ":flag_sg:", "southafrica" => ":flag_za:", "sydney" => ":flag_au:", "us-central" => ":flag_us:", "us-east" => ":flag_us:", "us-south" => ":flag_us:", "us-west" => ":flag_us:" };
  REGIONVALUE = { "brazil" => "Brazylia", "europe" => "Europa", "eu-central" => "Europa Centralna", "hongkong" => "Hong Kong", "india" => "India", "japan" => "Japonia", "russia" => "Rosja", "singapore" => "Singapur", "southafrica" => " Afryka Południowa", "sydney" => "Sydney", "us-central" => "U.S. Central", "us-east" => "U.S. East", "us-south" => "U.S. South", "us-west" => "U.S. West" };
  WRFLEVEL = { none: "Żaden", low: "Niski", medium: "Średni", high: "Wysoki", very_high: "Najwyższy" }
  NOTLVL = { all_messages: "Wszystkie wiadomości", only_mentions: "Tylko @wzmianki" }

  def initialize
    @name = "serwerinfo"
    @description = "Informacje o serwerze."
    @usage = nil
  end

  def run(event, args)
    #table = [
    #  "test",
    #  "test12"
    #]
    
    event.channel.send_embed do |embed|
      embed.color = "#00FF00"
      embed.title = "» Link do ikony serwera"
      embed.url = event.server.icon_url
      embed.add_field(name: "Nazwa Serwera", value: event.server.name, inline: true)
      embed.add_field(name: "Właściciel", value: event.server.owner.distinct, inline: true)
      embed.add_field(name: "Region  " + REGIONNAME[event.server.region.id], value: REGIONVALUE[event.server.region.id], inline: true)
      embed.add_field(name: "Kanał AFK", value: "#{event.server.afk_channel.name || "❎ Nie ma"}", inline: true)
      embed.add_field(name: "Ust. Powiadomień", value: "#{NOTLVL[event.server.default_message_notifications]}", inline: true)
      embed.add_field(name: "Poziom Weryfikacji", value: "#{WRFLEVEL[event.server.verification_level]}", inline: true)
      embed.add_field(name: "Identyfikator", value: "#{event.server.id}", inline: true)
      embed.add_field(name: "Dane serwera", value: "📝 » **Kanały Tekstowe:** `#{event.server.text_channels.size}`\n🔊 » **Kanały Głosowe:** `#{event.server.voice_channels.size}`\n🗄 » **Kategorie:** `#{event.server.categories.size}`\n🎇 » **Wszystkie:** `#{event.server.channels.size}`\n🍀 » **Role:** `#{event.server.roles.size-1}`\n🤖 » **Członkowie (z botami):** `#{event.server.member_count}`\n👤 » **Członkowie (bez botów):** `#{event.server.members.select {|member| !member.bot_account?}.size}`\n🌐 » **Online (bez botów):** `#{event.server.online_members.select {|member| !member.bot_account?}.size}`\n😴 » **Offline (bez botów):** `-`")
      embed.add_field(name: "Data utworzenia serwera", value: "#{event.server.creation_time.strftime("%H:%M:%S, %d.%m.%Yr.")}\n**(#{(Time.now - event.server.creation_time).to_i / (24 * 60 * 60)} dni temu)**")
      embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: event.server.icon_url)
    end
  end
end
module EventReady
  def self.run(bot)
    puts("Client #{bot.profile.username} is ready!")
    
    bot.watching = "#{bot.servers.size} serwerów"
  end
end
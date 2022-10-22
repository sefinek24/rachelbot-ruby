module EventMention
  def self.run(event)
    event.respond "**Komenda pomocy:** !pomoc\n**Prefix:** #{$config['prefix']}"
  end
end
class CommandPing
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  def initialize
    @name = "ping"
    @description = "Czas odpowiedzi bota."
    @usage = nil
  end

  def run(event, args)
    m = event.respond("🏓  **Ping!**")
    m.edit "🏓  **Pong!** Czas odpowiedzi to #{Time.now - event.timestamp} sekund."
  end
end
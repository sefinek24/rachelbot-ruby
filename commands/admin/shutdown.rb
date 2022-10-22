class CommandShutdown
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  def initialize
    @name = "shutdown"
    @description = nil
    @usage = nil
  end

  def run(event, args)
    return if event.author.id != 542026275410411520
    
    event.send_message "😥  **Bot wyłączony!**"
    exit
  end
end
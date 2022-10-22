class CommandTest
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  def initialize
    @name = "test"
    @description = nil
    @usage = nil
  end

  def run(event, args)
    return if event.author.id != 542026275410411520

  end
end
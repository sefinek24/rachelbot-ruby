class CommandEval
  attr_reader :description
  attr_reader :name
  attr_accessor :usage
  attr_accessor :category

  def initialize
    @name = "eval"
    @description = nil
    @usage = nil
  end

  def run(event, args)

  end
end
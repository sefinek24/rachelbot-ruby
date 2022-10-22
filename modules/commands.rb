class BotCommands
  attr_accessor :commands
  attr_accessor :categories

  def initialize(bot)
    @commands = {}

    Dir['./commands/*/*.rb'].sort.each do |file|
      name = file.split('/').last.split('.')[0]
      class_name = "Command#{name.capitalize}"

      require file
      command = Kernel.const_get(class_name).new
      @commands[command.name] = command
      @commands[command.name].category = file.split('/')[-2]
      @commands[command.name].usage = $config['prefix'] + @commands[command.name].name + " " + @commands[command.name].usage.to_s
    end

    @categories = @commands.values.map { |command| command.category }.uniq
    @categories.delete("admin")
  end
end
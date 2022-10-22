require "discordrb"
require "date"
require "json"
require "./events/ready"
require "./events/mention"
require "./modules/commands"

$config = JSON.parse(File.read 'config.json')

bot = Discordrb::Bot.new token: $config["token"]

bot.ready do
    EventReady.run(bot)
end

$command_manager = BotCommands.new(bot)

bot.message do |event|
    next if event.channel.pm?
    next unless event.content.start_with? $config['prefix']
    split = event.content.split(' ')
    name = split[0][$config['prefix'].length..-1]
    args = split.drop(1)

    command = $command_manager.commands[name]
    begin
        output = command.run(event, args) if command
        event << output if output.is_a?(String)
    rescue StandardError => e
        puts e
    end
end

bot.run
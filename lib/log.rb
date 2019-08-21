# frozen_string_literal: true

require 'json'
load 'lib/models/means.rb'
load 'lib/models/game.rb'
load 'lib/models/player.rb'

class Log
  attr_accessor :games

  def initialize(path)
    raise ArgumentError unless File.exist? path

    @log = File.open(path)
    @games = []
  end

  def read_log
    @log.each_line do |line|
      if line.include? 'InitGame'
        name = 'game_' + (@games.length + 1).to_s
        @game = Game.new(name)
      end

      if line.include? 'ClientUserinfoChanged'
        number = line.partition('ClientUserinfoChanged:').last[/\d+/]
        name = line[/n\\(.*?)\\t\\/, 1]

        player = @game.find_player_by_id(number)
        if player
          player.name = name unless player.name == name
        else
          player = @game.find_player_by_name(name)
          if player
            player.id = number
          else
            @game.players << Player.new(number, name)
          end
        end
      end

      if line.include? 'ClientDisconnect'
        number = line.partition('ClientDisconnect:').last[/\d+/]
        @game.find_player_by_id(number).id = 0
      end

      if line.include? 'Kill'
        @game.add_kill
        numbers = line.partition('Kill:').last.scan(/\d+/)

        if numbers[0].to_i == 1022
          @game.find_player_by_id(numbers[1]).decrease_kill
        else
          @game.find_player_by_id(numbers[0]).add_kill
        end

        numbers[2] = numbers[2].to_i

        if @game.kills_by_means.key?($means_of_death.key(numbers[2]))
          @game.kills_by_means[$means_of_death.key(numbers[2])] += 1
        else
          @game.kills_by_means[$means_of_death.key(numbers[2])] = 1
        end
      end

      if line.include? 'ShutdownGame'
        @games << @game
        @game = nil
      end
    end
  end

  def emit
    @games.each do |game|
      game.players.each do |player|
        game.kills[player.name] = player.kills
      end

      puts game.format
      puts game.ranking
    end
  end
end

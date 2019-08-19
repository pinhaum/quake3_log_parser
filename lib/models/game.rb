# frozen_string_literal: true

class Game
  attr_accessor :kills, :players, :total_kills, :name, :kills_by_means

  def initialize(name)
    @name = name
    @total_kills = 0
    @players = []
    @kills = {}
    @kills_by_means = {}
  end

  def add_kill
    @total_kills += 1
  end

  def add_player(player)
    @players << player unless @players.include? player
  end

  def find_player_by_id(id)
    @players.each do |player|
      return player if player.id == id
    end

    nil
  end

  def find_player_by_name(name)
    @players.each do |player|
      return player if player.name == name
    end

    nil
  end

  def format
    game = @name + ": {\n"
    game += "\ttotal_kills: " + @total_kills.to_s + ";\n"
    game += "\tplayers: " + @players.to_json + "\n"
    game += "\tkills: " + @kills.to_json + "\n"
    game += "\tkills_by_means: " + @kills_by_means.to_json + "\n"
    game += '}'

    game
  end

  def ranking
    kills = @kills.sort_by { |_k, v| v }.reverse
    ranking = "Ranking: \n"
    kills.each do |player, kill|
      ranking += player + ' - ' + kill.to_s + "\n"
    end

    ranking
  end
end

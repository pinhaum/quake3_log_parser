require 'test/unit'
load 'lib/models/game.rb'
load 'lib/models/player.rb'

class GameTest < Test::Unit::TestCase
  def setup
    @game = Game.new("game1")
  end

  def test_initialize
    assert_equal(0, @game.total_kills)
    assert_equal([], @game.players)
    assert_equal({}, @game.kills)
    assert_equal({}, @game.kills_by_means)
  end

  def test_add_kill
    @game.add_kill
    assert_equal(1, @game.total_kills)
  end

  def test_add_player
    @game.add_player(Player.new(2, "Isgalamido"))
    assert_equal(1, @game.players.length)
  end

  def test_add_same_player
    player = Player.new(2, "Isgalamido")
    @game.add_player(player)
    @game.add_player(player)
    assert_equal(1, @game.players.length)
  end

  def test_no_player_find_name
    assert_equal(nil, @game.find_player_by_name("Isgalamido"))
  end

  def test_find_by_name #find player name
    @game.add_player(Player.new(2, "Isgalamido"))
    @game.add_player(Player.new(3, "Pho"))
    @game.add_player(Player.new(4, "Jonnatan J. Jameson"))
    assert_equal(2, @game.find_player_by_name("Isgalamido").id)
  end

  def test_find_by_id #find player id
    @game.add_player(Player.new(2, "Isgalamido"))
    @game.add_player(Player.new(3, "Pho"))
    @game.add_player(Player.new(4, "Jonnatan J. Jameson"))
    assert_equal("Isgalamido", @game.find_player_by_id(2).name)
  end

end

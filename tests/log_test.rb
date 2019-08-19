require 'test/unit'
load 'lib/log.rb'
load 'lib/models/means.rb'

class LogTest< Test::Unit::TestCase
  def test_initialize
    assert_raises ArgumentError do
      log = Log.new('missing.log')
    end
  end

  def test_add_game
		log = Log.new('tests/logs/test.log')
		log.read_log
		assert_equal(3, log.games.length) #3 games in test.log
	end

  def test_add_player
    log = Log.new('tests/logs/test.log')
    log.read_log
    assert_equal(1, log.games.first().players.length)
  end

  def test_world_kill
    log = Log.new('tests/logs/world_kill.log')
    log.read_log
    assert_equal(1, log.games.first().total_kills)
    assert_equal(-1, log.games.first().players.first().kills)
  end

  def test_kill_by_mean
    log = Log.new('tests/logs/world_kill.log')
    log.read_log
    assert_equal(1, log.games.first().total_kills)
    assert_equal(1, log.games.first().kills_by_means[$means_of_death.key(19)])
  end

end

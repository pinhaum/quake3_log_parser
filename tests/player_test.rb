require 'test/unit'
load 'lib/models/player.rb'

class PlayerTest < Test::Unit::TestCase
  def setup
    @player = Player.new(2, "Isgalamido")
  end

  def test_initialize
    assert_equal(2, @player.id)
    assert_equal("Isgalamido", @player.name)
    assert_equal(0, @player.kills)
  end

  def test_add_kill
    @player.add_kill
    assert_equal(1, @player.kills)
  end

  def test_decrease_kill
    @player.decrease_kill
    assert_equal(-1, @player.kills)
  end

end

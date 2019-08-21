# frozen_string_literal: true

require 'spec_helper'
load 'lib/models/game.rb'

describe Game do
  context 'create a new object' do
    it 'should start with no players or kills' do
      game = Game.new('no_player_test')
      expect(game.total_kills).to eq(0)
      expect(game.players.length).to eq(0)
    end
  end

  context 'Kill' do
    before(:each) do
      @game = Game.new('kill_test')
      @killer_name = '#Killer'
      @killed_name = '#killed'
      @cause = '#Cause'
    end

    it 'should assign kill' do
      expect(@game.total_kills).to eq(0)
      @game.add_kill
      expect(@game.total_kills).to eq(1)

      kill = @game.kills[0]
      expect(kill.killer.kills).to eq(1)
      expect(kill.killed.deaths).to eq(1)
    end
  end
end

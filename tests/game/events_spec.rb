require_relative '../../player/constants'
require_relative '../../game/constants'
require_relative '../../coin/constants'
require_relative '../../game/manager'
require "test/unit"

class EventsTest < Test::Unit::TestCase
    include Game::Constants
    include Player::Constants
    include Coin::Constants

    def setup
        puts
        @player_one = PLAYER[:ONE][:name]
        @player_two = PLAYER[:TWO][:name]
        @game_manager = Game::Manager.new
    end

    def test_strike_event
        puts "test_strike_event"
        event = [ EVENTS[:STRIKE], { performed_by: @player_one, coin_type: COIN_TYPES[:black]}]
        event_type, event_args = event[0], event[1]
        performed_by = event_args[:performed_by]
        coin_type = event_args[:coin_type]

        details = @game_manager.player_manager.statuses.find {|player| player[:name] == performed_by}
        @game_manager.send("handle_strike_event", performed_by, event_args)
        updated_details = @game_manager.player_manager.statuses.find {|player| player[:name] == performed_by}
        assert_equal(updated_details[:points] - details[:points], INCREMENT_POINTS[coin_type])
    end
end
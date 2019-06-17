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
        @game = Game::Manager.new
    end

    def test_valid_strike_event
        puts "test_valid_strike_event"
        event_row = [ EVENTS[:STRIKE], { performed_by: @player_one, coin_type: COIN_TYPES[:black]}]
        event, args = event_row[0], event_row[1]
        performed_by = @player_one
        coin_type = args[:coin_type]

        details = @game.player_manager.statuses.find {|player| player[:name] == performed_by}
        remaining_coin_count = @game.coin_manager.remaining_count(coin_type)

        @game.send("handle_strike_event", performed_by, args)

        updated_details = @game.player_manager.statuses.find {|player| player[:name] == performed_by}
        updated_remaining_coin_count = @game.coin_manager.remaining_count(coin_type)

        assert_equal(updated_details[:points] - details[:points], INCREMENT_POINTS[coin_type])
        assert_equal(remaining_coin_count - updated_remaining_coin_count, 1)
    end

    def test_multi_strike_event
        puts "test_multi_strike_event"
        performed_by = @player_one
        event_row = [EVENTS[:MULTI_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 2 }}]
        event, args = event_row[0], event_row[1]
        coin_type, count = args[:coins_pocketed].first[0], args[:coins_pocketed].first[1]

        details = @game.player_manager.statuses.find {|player| player[:name] == performed_by}
        remaining_coin_count = @game.coin_manager.remaining_count(coin_type)

        @game.send("handle_multi_strike_event", performed_by, args)

        updated_details = @game.player_manager.statuses.find {|player| player[:name] == performed_by}
        updated_remaining_coin_count = @game.coin_manager.remaining_count(coin_type)

        assert_equal(updated_details[:points] - details[:points], INCREMENT_POINTS[:multi_strike])
        assert_equal(remaining_coin_count - updated_remaining_coin_count, MAXIMUM_DISCARD_COINS[:multi_strike])
    end

    def test_multi_strike_with_more_coins_discard_only_limited
        puts "test_multi_strike_with_more_coins_discard_only_limited"
        performed_by = @player_one
        event_row = [EVENTS[:MULTI_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 5 }}]
        event, args = event_row[0], event_row[1]
        coin_type, count = args[:coins_pocketed].first[0], args[:coins_pocketed].first[1]

        details = @game.player_manager.statuses.find {|player| player[:name] == performed_by}
        remaining_coin_count = @game.coin_manager.remaining_count(coin_type)

        @game.send("handle_multi_strike_event", performed_by, args)

        updated_details = @game.player_manager.statuses.find {|player| player[:name] == performed_by}
        updated_remaining_coin_count = @game.coin_manager.remaining_count(coin_type)

        assert_equal(updated_details[:points] - details[:points], INCREMENT_POINTS[:multi_strike])
        assert_equal(remaining_coin_count - updated_remaining_coin_count, MAXIMUM_DISCARD_COINS[:multi_strike])
    end
end
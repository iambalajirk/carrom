require_relative '../../player/constants'
require_relative '../../game/constants'
require_relative '../../coin/constants'
require_relative '../../game/manager'
require "test/unit"

class ValidatorTest < Test::Unit::TestCase
    include Game::Constants
    include Player::Constants
    include Coin::Constants

    TOTAL_COINS = 9

    def setup
        puts
        @player_one = PLAYER[:ONE][:name]
        @player_two = PLAYER[:TWO][:name]
        @game_manager = Game::Manager.new
    end

    def test_valid_strike_event
        puts 'test_valid_strike_event'
        event = [ EVENTS[:STRIKE], { coin_type: COIN_TYPES[:black]}]
        event_type, event_args = event[0], event[1]
        performed_by = @player_one

        result = @game_manager.send('valid_event?', event_type, performed_by, event_args)
        assert(result)
    end

    def test_strike_event_without_coin_type
        puts 'test_strike_event_without_coin_type'
        event = [ EVENTS[:STRIKE], { performed_by: @player_one}]
        event_type, event_args = event[0], event[1]
        performed_by = @player_one

        result = @game_manager.send('valid_event?', event_type, performed_by, event_args)
        assert_equal(result, false)
    end

    def test_strike_event_without_not_enough_coins
        puts 'test_strike_event_without_not_enough_coins'
        event = [ EVENTS[:STRIKE], { coin_type: COIN_TYPES[:black]}]
        event_type, event_args = event[0], event[1]
        performed_by = @player_one
        coin_type = event_args[:coin_type]

        @game_manager.coin_manager.discard_coins(coin_type, TOTAL_COINS)

        result = @game_manager.send('valid_event?', event_type, performed_by, event_args)
        assert_equal(result, false)
    end

    def test_valid_multi_strike_events
        puts 'test_valid_multi_strike_events'
        event = [ EVENTS[:MULTI_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 2}}]
        event_type, event_args = event[0], event[1]
        performed_by = @player_one

        result = @game_manager.send('valid_event?', event_type, performed_by, event_args)
        assert(result)
    end

    def test_multi_strike_events_with_no_coins_pocketed
        puts 'test_multi_strike_events_with_no_coins_pocketed'
        event = [ EVENTS[:MULTI_STRIKE], { performed_by: @player_one}]
        event_type, event_args = event[0], event[1]
        performed_by = @player_one

        result = @game_manager.send('valid_event?', event_type, performed_by, event_args)
        assert_equal(result, false)
    end

    def test_multi_strike_events_with_less_coins_pocketed
        puts 'test_multi_strike_events_with_no_coins_pocketed'
        event = [ EVENTS[:MULTI_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 1}}]
        event_type, event_args = event[0], event[1]
        performed_by = @player_one

        result = @game_manager.send('valid_event?', event_type, performed_by, event_args)
        assert_equal(result, false)
    end

    def test_multi_strike_events_with_no_coins_available
        puts 'test_multi_strike_events_with_no_coins_available'
        event = [ EVENTS[:MULTI_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 3}}]
        event_type, event_args = event[0], event[1]
        performed_by = @player_one
        event_args[:coins_pocketed].each do |coin_type, count|
            @game_manager.coin_manager.discard_coins(coin_type, TOTAL_COINS)
            result = @game_manager.send('valid_event?', event_type, performed_by, event_args)
            assert_equal(result, false)
        end
    end

    def test_valid_red_strike
        puts "test_valid_red_strike"
        event = [ EVENTS[:RED_STRIKE], { performed_by: @player_one}]
        event_type, event_args = event[0], event[1]
        performed_by = @player_one

        result = @game_manager.send('valid_event?', event_type, performed_by, event_args)
        assert(result)
    end

    def test_red_strike_with_no_coin_left
        puts "test_red_strike_with_no_coin_left"
        event = [ EVENTS[:RED_STRIKE], { performed_by: @player_one}]
        event_type, event_args = event[0], event[1]
        performed_by = @player_one

        @game_manager.coin_manager.discard_coins(COIN_TYPES[:red], TOTAL_COINS)
        result = @game_manager.send('valid_event?', event_type, performed_by, event_args)
        assert_equal(result, false)
    end
end
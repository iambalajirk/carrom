require_relative '../coin/constants'

module Game
  module Events
    include Constants
    include Coin::Constants

    private

    def handle_strike_event(performed_by, args = {})
      coin_type = args[:coin_type] || COIN_TYPES[:black]
      points = INCREMENT_POINTS[coin_type]

      perform_coin_pocketed_action(performed_by, points, coin_type)
    end

    def handle_multi_strike_event(performed_by, args = {})
      coin_type = args[:coin_type] || COIN_TYPES[:black]
      points = INCREMENT_POINTS[:multi_strike]

      args[:coins_pocketed].each do |coin_type, coins_pocketed|
        if coins_pocketed >= 2
          perform_coin_pocketed_action(performed_by, points, coin_type, MAXIMUM_DISCARD_COINS[:multi_strike])
        else
          handle_strike_event(performed_by, coin_type: coin_type)
        end
      end
    end

    def handle_red_strike_event(performed_by, _args = {})
      coin_type = COIN_TYPES[:red]
      points = INCREMENT_POINTS[coin_type]

      perform_coin_pocketed_action(performed_by, points, coin_type)
    end

    def handle_striker_strike_event(performed_by, _args = {})
      points_to_decrease = DECREMENT_POINTS[:striker_strike]

      perform_decrement_action(performed_by, points_to_decrease)
    end

    def handle_defunct_coin_event(performed_by, args = {})
      args[:defunct_coins].each do |coin_type, coins_to_discard|
        points_to_decrease = coins_to_discard * DECREMENT_POINTS[:defunct_coin]
        coin_manager.discard_coins(coin_type, coins_to_discard)
        perform_decrement_action(performed_by, points_to_decrease)
      end
    end

    def handle_missed_strike_event(player, _args = {})
      misses = player_manager.increment_misses(player)

      if misses >= MISSES_LIMIT
        puts MESSAGES[:decrement_point_for_misses] % { player: player, limit: MISSES_LIMIT }

        points_to_decrease = DECREMENT_POINTS[:missed_strike]
        perform_decrement_action(player, points_to_decrease)
        player_manager.reset_misses(player)
      end
    end

    def perform_coin_pocketed_action(player, points_to_award, coin_type, coins_pocketed = 1, _args = {})
      player_manager.increment_points(player, points_to_award)
      coin_manager.discard_coins(coin_type, coins_pocketed)
    end

    def perform_decrement_action(player, point_to_reduce, increment_fouls = true, fouls_to_increase = 1)
      player_manager.decrement_points(player, point_to_reduce)
      handle_fouls(player, fouls_to_increase) if increment_fouls
    end

    def handle_fouls(player, fouls_to_increase = 1, _args = {})
      fouls = player_manager.increment_fouls(player, fouls_to_increase)

      if fouls >= FOULS_LIMIT
        puts MESSAGES[:decrement_point_for_fouls] % { player: player, limit: FOULS_LIMIT }

        player_manager.decrement_points(player, DECREMENT_POINTS[:fouls])
        player_manager.reset_fouls(player)
      end
    end
  end
end

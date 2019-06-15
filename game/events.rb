require_relative '../coin/constants'

module Game
    module Events
        include Coin::Constants

        def handle_strike_event(performed_by, args={})
            coin_type = args[:coin_type] || COIN_TYPES[:black]
            points = INCREMENT_POINTS[coin_type]

            perform_coin_pocketed_action(performed_by, points, coin_type)
        end

        def handle_multi_strike_event(performed_by, args={})
            coin_type = args[:coin_type] || COIN_TYPES[:black]
            points = INCREMENT_POINTS[:multi_strike]

            perform_coin_pocketed_action(performed_by, points, coin_type, MAXIMUM_DISCARD_COINS[:multi_strike])
        end

        def handle_red_strike_event(performed_by, args={})
            coin_type = COIN_TYPES[:red]
            points = INCREMENT_POINTS[coin_type]

            perform_coin_pocketed_action(performed_by, points, coin_type)
        end

        def handle_striker_strike_event(performed_by, args={})
            points_to_decrease = DECREMENT_POINTS[:striker_strike]

            perform_decrement_action(performed_by, points_to_decrease)
        end

        def handle_defunct_coin_event(performed_by, args={})
            args[:defunct_coins].each do |coin_type, coins_to_discard|
                remaining_coin_count = coin_manager.remaining_count(coin_type)
                if remaining_coin_count <= 0 || ( coins_to_discard > remaining_coin_count )
                    puts "(Invalid event) Not enough #{coin_type.upcase} coins to perform event..."
                    next
                end

                points_to_decrease = coins_to_discard * DECREMENT_POINTS[:defunct_coin]
                coin_manager.discard_coins(coin_type, coins_to_discard)
                perform_decrement_action(performed_by, points_to_decrease)
            end
        end

        def handle_missed_strike_event(player, args={})
            misses = player_manager.increment_misses(player)

            if misses >= MISSES_LIMIT
                puts "Decrementing a point as #{player} has done #{MISSES_LIMIT} misses and resetting misses...."

                points_to_decrease = DECREMENT_POINTS[:missed_strike]
                perform_decrement_action(player, points_to_decrease)
                player_manager.reset_misses(player)
            end
        end

        private

        def perform_coin_pocketed_action(player, points_to_award, coin_type, coins_pocketed = 1, args = {})
            remaining_coin_count = coin_manager.remaining_count(coin_type)
            if remaining_coin_count <= 0 || ( coins_pocketed > remaining_coin_count )
                puts "(Invalid event) Not enough #{coin_type.upcase} coins to perform event..."
                return
            end
            
            player_manager.increment_points(player, points_to_award)
            coin_manager.discard_coins(coin_type, coins_pocketed)
        end

        def perform_decrement_action(player, point_to_reduce, increment_fouls = true, fouls_to_increase = 1)
            player_manager.decrement_points(player, point_to_reduce)
            handle_fouls(player, fouls_to_increase) if increment_fouls
        end

        def handle_fouls(player, fouls_to_increase = 1, args={})
            fouls = player_manager.increment_fouls(player, fouls_to_increase)

            if fouls >= FOULS_LIMIT
                puts "Decrementing a point as #{player} has commited #{FOULS_LIMIT} new fouls and resetting fouls...."

                player_manager.decrement_points(player, DECREMENT_POINTS[:fouls])
                player_manager.increment_skip_turns(player)
                player_manager.reset_fouls(player)
            end
        end
    end
end
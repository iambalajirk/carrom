require_relative '../coin/constants'

module Game
    module Events
        include Coin::Constants

        private

        def handle_strike_event(performed_by, args={})
            coin_type = args[:coin_type] || COIN_TYPES[:black]
            points = INCREMENT_POINTS[coin_type]

            perform_coin_pocketed_action(performed_by, points, coin_type)
        end

        def handle_multi_strike_event(performed_by, args={})
            points = INCREMENT_POINTS[:multi_strike]

            args[:coins_pocketed].each do |coin_type, coins_pocketed|
                if coins_pocketed >= 2
                    perform_coin_pocketed_action(performed_by, points, coin_type,  MAXIMUM_DISCARD_COINS[:multi_strike]) 
                else
                    handle_strike_event(performed_by, {coin_type: coin_type})
                end
            end
        end

        def handle_red_strike_event(performed_by, args={})
            red_coin = COIN_TYPES[:red]
            points = INCREMENT_POINTS[red_coin]

            player = player_manager.details(performed_by)
            primary_coin = player[:coins_allowed].find { |coin| coin != COIN_TYPES[:red] }
            coins_pocketed = args[:coins_pocketed] || []

            if player[:coins_pocketed][primary_coin] > 0
                if coins_pocketed.empty?
                   puts "Pushing Red coin to the queue and waiting for the next turn..."
                   push_to_event_queue(performed_by, { red_coin_in_queue: true})
                else
                    coins_pocketed.each do |coin, count|
                        normal_coin_points = count * INCREMENT_POINTS[coin]
                        result = perform_coin_pocketed_action(performed_by, normal_coin_points, coin)

                        if (result != "Wrong pocket" || result != "Not enough coins")
                            perform_coin_pocketed_action(performed_by, points, red_coin)
                        end
                    end
                end
            else
                coins_pocketed.each do |coin, count|
                    normal_coin_points = count * INCREMENT_POINTS[coin]
                    result = perform_coin_pocketed_action(performed_by, normal_coin_points, coin)
                end
                puts "#{performed_by} has not pocketed a coin of type #{primary_coin.upcase}. So, can't pocket RED coin."
            end
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

        def perform_coin_pocketed_action(player, points_to_award, coin_type, coins_pocketed = 1, args = {})
            if !player_manager.valid_action(player, coin_type)
                handle_wrong_pocket(player, coin_type, coins_pocketed) 
                return  "Wrong pocket"
            end
                
            remaining_coin_count = coin_manager.remaining_count(coin_type)
            if remaining_coin_count <= 0 || ( coins_pocketed > remaining_coin_count )
                puts "(Invalid event) Not enough #{coin_type.upcase} coins to perform event..."
                return "Not enough coins"
            end
            
            player_manager.handle_coins_pocketed(player, coin_type, coins_pocketed)
            player_manager.increment_points(player, points_to_award)
            coin_manager.discard_coins(coin_type, coins_pocketed)
        end

        def process_event_queue(event, player, args)
            queue = event_queue[player]
            return if queue.nil?
            
            if queue[:red_coin_in_queue]
                queue.delete(:red_coin_in_queue)
                primary_coin = player_manager.primary_coin(player)
                valid_follow_up_event = [ EVENT_TYPES[:STRIKE], EVENT_TYPES[:MULTI_STRIKE] ].include?(event)
                valid_follow_up_coin = args[:coin_type] == primary_coin if event == EVENT_TYPES[:STRIKE]
                valid_follow_up_coin = (args[:coins_pocketed] || {}).keys.include?(primary_coin) if event == EVENT_TYPES[:MULTI_STRIKE] 

                if valid_follow_up_event && valid_follow_up_coin
                    red_coin = COIN_TYPES[:red]
                    points = INCREMENT_POINTS[red_coin]

                    perform_coin_pocketed_action(player, points, red_coin)
                end
            end

            event_queue.delete(player) if event_queue[player].keys.size == 0
        end

        def push_to_event_queue(player, property)
            event_queue[player] = {} if event_queue[player].nil?

            event_queue[player].merge!(property)
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
                player_manager.reset_fouls(player)
            end
        end

        def handle_wrong_pocket(player, coin_type, coins_pocketed)
            puts "#{player} pocketed a #{coin_type.upcase} coin. decrementing points..."

            perform_decrement_action(player, DECREMENT_POINTS[:wrong_pocket])
            coin_manager.discard_coins(coin_type, coins_pocketed)
        end

    end
end
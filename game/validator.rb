module Game
    module Validator
        private

        def validate_strike_event(performed_by, args)
            return false unless validates_presence(args[:coin_type])
            return false unless enough_coin_left?(args[:coin_type], 1)
        end

        def validate_multi_strike_event(performed_by, args)
            return false unless validates_presence(args[:coins_pocketed])

            total_coins_pocketed = args[:coins_pocketed].values.inject('+')
            if total_coins_pocketed < 2
                puts MESSAGES[:not_enough_coins_multi_strike]
                return false
            end
                
            args[:coins_pocketed].each do |coin_type, coins_pocketed|
                return false unless enough_coin_left?(coin_type, coins_pocketed)
            end
        end

        def validate_red_strike_event(performed_by, args)
            red_coin = COIN_TYPES[:red]
            return false unless enough_coin_left?(red_coin, 1)

            (args[:coins_pocketed] || {}).each do |coin_type, coins_pocketed|
                return false unless enough_coin_left?(coin_type, coins_pocketed)
            end
        end

        def validate_defunct_coin_event(performed_by, args)
            args[:defunct_coins].each do |coin_type, defunct_coins|
                return false unless enough_coin_left?(coin_type, defunct_coins)
            end
        end

        # Helpers..
        def validates_presence(coin_type)
            if coin_type.nil? 
                puts MESSAGES[:coin_type_not_present]
                false
            else 
                true
            end
        end

        def enough_coin_left?(coin_type, coins_pocketed)
            remaining_coin_count = coin_manager.remaining_count(coin_type)

            if remaining_coin_count <= 0 || ( coins_pocketed > remaining_coin_count )
                puts MESSAGES[:not_enough_coins] % {coin_type: coin_type.upcase}
                false
            else
                true
            end
        end
    end
end
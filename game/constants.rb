module Game
    module Constants
        EVENTS = {
            STRIKE: 'strike',
            MULTI_STRIKE: 'multi_strike',
            RED_STRIKE: 'red_strike',
            STRIKER_STRIKE: 'striker_strike',
            DEFUNCT_COIN: 'defunct_coin',
            MISSED_STRIKE: 'missed_strike'
        }

        EVENT_TYPES = EVENTS.values.freeze

        MISSES_LIMIT = 3
        FOULS_LIMIT = 3
        
        MINIMUM_POINTS_TO_WIN = 5
        MINIMUM_DIFFERENCE_TO_WIN = 3

        CONTINUE_EVENT = {
            EVENTS[:STRIKE] => false,
            EVENTS[:MULTI_STRIKE] => false,
            EVENTS[:RED_STRIKE] => false,
            EVENTS[:STRIKER_STRIKE] => false,
            EVENTS[:DEFUNCT_COIN] => false,
            EVENTS[:MISSED_STRIKE] => false,
        }

        DECREMENT_POINTS = {
            defunct_coin: 2,
            striker_strike: 1,
            missed_strike: 1,
            fouls: 1
        }

        MAXIMUM_DISCARD_COINS = {
            multi_strike: 2
        }

        ERRORS = {
            not_enough_coins: "Not enough coins"
        }

        MESSAGES = {
            not_enough_coins: "(Invalid event) Not enough %{coin_type} coins to perform event...",
            coin_type_not_present:  "Coin type not present",
            not_enough_coins_multi_strike: "Not enough coins in multistrike event.",
            decrement_point_for_misses: "Decrementing a point as %{player} has done %{limit} misses and resetting misses....",
            decrement_point_for_fouls: "Decrementing a point as %{player} has commited %{limit} new fouls and resetting fouls....",
        }
    end
end
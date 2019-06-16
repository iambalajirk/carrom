module Game
    module Constants
        EVENT_TYPES = {
            STRIKE: 'strike',
            MULTI_STRIKE: 'multi_strike',
            RED_STRIKE: 'red_strike',
            STRIKER_STRIKE: 'striker_strike',
            DEFUNCT_COIN: 'defunct_coin',
            MISSED_STRIKE: 'missed_strike'
        }

        MISSES_LIMIT = 3
        FOULS_LIMIT = 3
        
        MINIMUM_POINTS_TO_WIN = 5
        MINIMUM_DIFFERENCE_TO_WIN = 3

        CONTINUE_EVENT = {
            EVENT_TYPES[:STRIKE] => true,
            EVENT_TYPES[:MULTI_STRIKE] => true,
            EVENT_TYPES[:RED_STRIKE] => true,
            EVENT_TYPES[:STRIKER_STRIKE] => false,
            EVENT_TYPES[:DEFUNCT_COIN] => false,
            EVENT_TYPES[:MISSED_STRIKE] => false,
        }
    end
end
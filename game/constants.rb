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
    end
end
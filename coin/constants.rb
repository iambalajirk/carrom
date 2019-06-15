module Coin
    module Constants
        COIN_TYPES = {
            black: 'black',
            red: 'red'
        }

        COIN_PROPERTIES = {
            COIN_TYPES[:black] => {count: 9},
            COIN_TYPES[:red] => {count: 1}
        }.freeze
        
        INCREMENT_POINTS = {
            COIN_TYPES[:black] => 1,
            COIN_TYPES[:red] => 3,
            :multi_strike => 2
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
    end
end
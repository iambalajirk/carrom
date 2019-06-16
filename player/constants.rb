require_relative '../coin/constants'
module Player
    module Constants
        include Coin::Constants
        
        DEFAULT_COINS_ALLOWED =  [COIN_TYPES[:white], COIN_TYPES[:red]]
        DEFAULT_COINS_POCKETED = {COIN_TYPES[:white] => 0, COIN_TYPES[:red] => 0}
        PLAYER = {
            :ONE => {
                name: 'player_1',
                coins_allowed: [COIN_TYPES[:white], COIN_TYPES[:red]],
                coins_pocketed: {COIN_TYPES[:white] => 0, COIN_TYPES[:red] => 0}
            },
            :TWO => {
                name: 'player_2',
                coins_allowed: [COIN_TYPES[:black], COIN_TYPES[:red]],
                coins_pocketed: {COIN_TYPES[:black] => 0, COIN_TYPES[:red] => 0}
            }
        }
    end
end
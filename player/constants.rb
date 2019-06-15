require_relative '../coin/constants'
module Player
    module Constants
        include Coin::Constants
        
        PLAYER = {
            :ONE => {name: 'player_1', coins_allowed: [COIN_TYPES[:white], COIN_TYPES[:red]]},
            :TWO => {name: 'player_2', coins_allowed: [COIN_TYPES[:black], COIN_TYPES[:red]] }
        }
    end
end
require_relative './game/constants'
require_relative './coin/constants'
require_relative './player/constants'

module EVENT_SIMULATIONS
    include Game::Constants
    include Coin::Constants
    include Player::Constants

    def simulations
        player_one = PLAYER[:ONE][:name]
        player_two = PLAYER[:TWO][:name]

        [
            {
                player_one => [
                    [ EVENTS[:MISSED_STRIKE], { performed_by: player_one }],
                    [ EVENTS[:DEFUNCT_COIN], { performed_by: player_one, defunct_coins: { COIN_TYPES[:black] => 10}}],
                    [ EVENTS[:RED_STRIKE], { performed_by: player_one}],
                    [ EVENTS[:DEFUNCT_COIN], { performed_by: player_one, defunct_coins: { COIN_TYPES[:black] => 1}}],
                    [ EVENTS[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: { COIN_TYPES[:black] => 2} }],
                    [ EVENTS[:RED_STRIKE], { performed_by: player_one, coins_pocketed: { COIN_TYPES[:black] => 1} }],
                    [ EVENTS[:STRIKE], { performed_by: player_one, coin_type: COIN_TYPES[:black] }],
                    [ EVENTS[:MISSED_STRIKE], { performed_by: player_one }],
                    [ EVENTS[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: { COIN_TYPES[:black] => 2} }],
                    [ EVENTS[:STRIKE], { performed_by: player_one, coin_type: COIN_TYPES[:black] }],
                ],
                player_two => [
                    [ EVENTS[:MISSED_STRIKE], { performed_by: player_two }],
                    [ EVENTS[:DEFUNCT_COIN], { performed_by: player_two, defunct_coins: { COIN_TYPES[:black] => 1}}],
                    [ EVENTS[:STRIKE], { performed_by: player_two, coin_type: COIN_TYPES[:black] }],
                    [ EVENTS[:MISSED_STRIKE], { performed_by: player_two }],
                    [ EVENTS[:MULTI_STRIKE], { performed_by: player_two, coins_pocketed: { COIN_TYPES[:black] => 2} }],
                    [ EVENTS[:STRIKE], { performed_by: player_two, coin_type: COIN_TYPES[:black]}],
                    [ EVENTS[:MISSED_STRIKE], { performed_by: player_one }],
                    [ EVENTS[:RED_STRIKE], { performed_by: player_two}],
                    [ EVENTS[:MULTI_STRIKE], { performed_by: player_two, coins_pocketed: { COIN_TYPES[:black] => 2, COIN_TYPES[:black] => 1} }],
                ]   
            }
        ]
    end
end
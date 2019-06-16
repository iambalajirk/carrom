require_relative './game/constants'
require_relative './coin/constants'
require_relative './player/constants'

module SampleInput
    include Game::Constants
    include Coin::Constants
    include Player::Constants

    def simulations
        player_one = PLAYER[:ONE][:name]
        player_two = PLAYER[:TWO][:name]

        [
            {
                player_one => [
                    [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                    [ EVENT_TYPES[:RED_STRIKE], { performed_by: player_one, coins_pocketed: { COIN_TYPES[:black] => 1} }],
                    [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: { COIN_TYPES[:black] => 2, COIN_TYPES[:black] => 1} }],
                    [ EVENT_TYPES[:RED_STRIKE], { performed_by: player_one }],
                    [ EVENT_TYPES[:STRIKE], { performed_by: player_one, coin_type: COIN_TYPES[:black] }],
                    [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                    [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: { COIN_TYPES[:black] => 2} }],
                    [ EVENT_TYPES[:STRIKE], { performed_by: player_one, coin_type: COIN_TYPES[:black] }],
                ],
                player_two => [
                    [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_two }],
                    [ EVENT_TYPES[:STRIKE], { performed_by: player_two }],
                    [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_two }],
                    [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_two, coins_pocketed: { COIN_TYPES[:black] => 2} }],
                    [ EVENT_TYPES[:STRIKE], { performed_by: player_two}],
                    [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                    [ EVENT_TYPES[:RED_STRIKE], { performed_by: player_two}],
                    [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_two, coins_pocketed: { COIN_TYPES[:black] => 2, COIN_TYPES[:black] => 1} }],
                    # [ EVENT_TYPES[:STRIKE], { performed_by: player_two}],
                ]   
            }
        ]
    end
end
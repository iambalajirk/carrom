require_relative './game/constants'
require_relative './coin/constants'
require_relative './player/constants'

module SampleInput
    include Game::Constants
    include Coin::Constants
    include Player::Constants

    def simulations
        player_one_configs = PLAYER[:ONE]
        player_two_configs = PLAYER[:TWO]
        player_one = player_one_configs[:name]
        player_two = player_two_configs[:name]

        [
            [
                [ EVENT_TYPES[:STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: 3 }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: 2 }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_two}]
            ],
            [
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: 4 }],
                [ EVENT_TYPES[:STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: 2 }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_two, coins_pocketed: 2 }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_two, coins_pocketed: 2}],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:RED_STRIKE], { performed_by: player_one }],
            ],
            [
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: 4 }],
                [ EVENT_TYPES[:STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: 2 }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_two, coins_pocketed: 2 }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_two, coins_pocketed: 2}],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:STRIKER_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:RED_STRIKE], { performed_by: player_one }],
            ],
            [
                [ 
                    EVENT_TYPES[:DEFUNCT_COIN], { 
                        performed_by: player_one,
                        defunct_coins: {
                            COIN_TYPES[:black] => 1
                        }
                    }
                ],
                [
                    EVENT_TYPES[:DEFUNCT_COIN], { 
                        performed_by: player_two,
                        defunct_coins: {
                            COIN_TYPES[:red] => 1,
                            COIN_TYPES[:black] => 1
                        }
                    }
                ],
                [
                    EVENT_TYPES[:DEFUNCT_COIN], { 
                        performed_by: player_one,
                        defunct_coins: {
                            COIN_TYPES[:black] => 2
                        }
                    }
                ],
                [
                    EVENT_TYPES[:DEFUNCT_COIN], { 
                        performed_by: player_one,
                        defunct_coins: {
                            COIN_TYPES[:red] => 1
                        }
                    }
                ],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_one, coins_pocketed: 2 }],
                [ EVENT_TYPES[:MULTI_STRIKE], { performed_by: player_two, coins_pocketed: 2 }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_one }],
                [ EVENT_TYPES[:MISSED_STRIKE], { performed_by: player_two }],
                [ EVENT_TYPES[:STRIKE], { performed_by: player_one }],
            ]
        ]
    end
end






















# def simulations
    #     [
    #         {
    #             PLAYER[:ONE] => { event: EVENT_TYPES[:STRIKE] },
    #             PLAYER[:TWO] => { event: EVENT_TYPES[:STRIKE] },
    #             PLAYER[:ONE] => { event: EVENT_TYPES[:MULTI_STRIKE], args: {coins: 3} },
    #             PLAYER[:TWO] => { event: EVENT_TYPES[:STRIKE] },
    #             PLAYER[:ONE] => { event: EVENT_TYPES[:MULTI_STRIKE], args: {coins: 2} },
    #             PLAYER[:TWO] => { event: EVENT_TYPES[:MISSED_STRIKE] },
    #             PLAYER[:ONE] => { event: EVENT_TYPES[:STRIKE] },
    #             PLAYER[:TWO] => { event: EVENT_TYPES[:MISSED_STRIKE] }
    #         }
    #     ]
    # end


        # events.each do |performed_by, args|
    #     event = args[:event]
    #     event_handler.handle(event, performed_by, args)
    #     game_manager.print_status

    #     if game_manager.game_completed
    #         game_manager.print_winner
    #     end
    # end
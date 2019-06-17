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
          [EVENTS[:MISSED_STRIKE], {}],
          [EVENTS[:DEFUNCT_COIN], { defunct_coins: { COIN_TYPES[:black] => 10 } }],
          [EVENTS[:RED_STRIKE], {}],
          [EVENTS[:DEFUNCT_COIN], { defunct_coins: { COIN_TYPES[:black] => 1 } }],
          [EVENTS[:MULTI_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 2 } }],
          [EVENTS[:RED_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 1 } }],
          [EVENTS[:STRIKE], { coin_type: COIN_TYPES[:black] }],
        ],
        player_two => [
          [EVENTS[:MISSED_STRIKE], {}],
          [EVENTS[:DEFUNCT_COIN], { defunct_coins: { COIN_TYPES[:black] => 1 } }],
          [EVENTS[:STRIKE], { coin_type: COIN_TYPES[:black] }],
          [EVENTS[:MISSED_STRIKE], {}],
          [EVENTS[:MULTI_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 2 } }],
          [EVENTS[:STRIKE], { coin_type: COIN_TYPES[:black] }],
          [EVENTS[:MISSED_STRIKE], {}]
        ]
      },
      {
        player_one => [
          [EVENTS[:RED_STRIKE], {}],
          [EVENTS[:MISSED_STRIKE], {}],
          [EVENTS[:MULTI_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 2 } }]
        ],
        player_two => [
          [EVENTS[:MISSED_STRIKE], {}],
          [EVENTS[:DEFUNCT_COIN], { defunct_coins: { COIN_TYPES[:black] => 1 } }],
          [EVENTS[:STRIKE], { coin_type: COIN_TYPES[:black] }]
        ]
      },
      {
        player_one => [
            [EVENTS[:DEFUNCT_COIN], { defunct_coins: { COIN_TYPES[:black] => 2 } }],
            [EVENTS[:MULTI_STRIKE], { coins_pocketed: { COIN_TYPES[:black] => 2 } }],
            [EVENTS[:STRIKE], { coin_type: COIN_TYPES[:black] }],
            [EVENTS[:RED_STRIKE], {}],
            [EVENTS[:MISSED_STRIKE], {}]
          ],
          player_two => [
            [EVENTS[:DEFUNCT_COIN], { defunct_coins: { COIN_TYPES[:black] => 2 } }],
            [EVENTS[:DEFUNCT_COIN], { defunct_coins: { COIN_TYPES[:black] => 2 } }],
            [EVENTS[:MISSED_STRIKE], {}],
            [EVENTS[:DEFUNCT_COIN], { defunct_coins: { COIN_TYPES[:black] => 1 } }],
            [EVENTS[:STRIKE], { coin_type: COIN_TYPES[:black] }]
          ]
      }
    ]
  end
end

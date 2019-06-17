module Coin
  module Constants
    COIN_TYPES = {
      black: 'black',
      red: 'red'
    }.freeze

    COIN_PROPERTIES = {
      COIN_TYPES[:black] => { count: 9 },
      COIN_TYPES[:red] => { count: 1 }
    }.freeze
  end
end

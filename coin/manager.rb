require_relative './coin'
require_relative './constants'
module Coin
  class Manager
    include Constants
    attr_accessor :coins

    def initialize(_options = {})
      @coins = {}

      COIN_PROPERTIES.each do |type, properties|
        coins[type] = Coin.new(type, properties)
      end
    end

    def statuses
      coins.map { |_type, coin| coin.details }
    end

    def discard_coins(type, count = 1)
      coin = get_coin(type)

      coin.count = coin.count - count
    end

    def total_coins_left
      coins.values.inject(0) { |coins_left, coin| coins_left + coin.count }
    end

    def remaining_count(type)
      coin = get_coin(type)
      coin.count
    end

    def get_coin(type)
      coins[type]
    end
  end
end

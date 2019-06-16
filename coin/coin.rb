module Coin
  class Coin
    attr_accessor :count, :type

    def initialize(type, options)
      @count = options[:count]
      @type = type
    end

    def details
      {
        type: type,
        count: count
      }
    end
  end
end

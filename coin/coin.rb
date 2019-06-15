module Coin
    class Coin
        attr_accessor :count, :type

        def initialize(type, options)
            @count = options[:count]
            @type = type
        end

        def details
            {
                count: count,
                type: type
            }
        end
    end
end
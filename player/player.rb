module Player
    class Player
        attr_accessor :name, :coins_allowed, :points, :fouls, :misses

        def initialize(options = {})
            @name = options[:name]
            @coins_allowed = options[:coins_allowed]
            @points = 0
            @fouls = 0
            @misses = 0
        end

        def details
            {
                name: name,
                coins_allowed: coins_allowed,
                points: points,
                fouls: fouls,
                misses: misses,
            }
        end
    end
end
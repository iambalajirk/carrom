module Player
    class Player
        attr_accessor :name, :coins_allowed, :coins_pocketed, :points, :fouls, :misses

        def initialize(options = {})
            @name = options[:name]
            @coins_allowed = options[:coins_allowed]
            @coins_pocketed = options[:coins_pocketed]
            @points = 0
            @fouls = 0
            @misses = 0
        end

        def details
            {
                name: name,
                coins_allowed: coins_allowed,
                coins_pocketed: coins_pocketed,
                points: points,
                fouls: fouls,
                misses: misses,
            }
        end
    end
end